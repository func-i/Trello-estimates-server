require "harvested"

namespace :harvest do

  def get_harvest_client
    Harvest.hardy_client(
      subdomain:  Figaro.env.harvest_subdomain,
      username:   Figaro.env.harvest_username,
      password:   Figaro.env.harvest_password
    )
  end

  task :track_time => :environment do
    harvest_client = get_harvest_client

    while true
      harvest_client.users.all.collect(&:id).each do |user_id|
        harvest_client.time.all(Date.today, user_id).each do |daily_task_log|
          begin
            if daily_task_log.timer_started_at.blank?
              Tasks::HarvestLogImporter.new(harvest_client, daily_task_log).perform
            end
          rescue Exception => e
            puts e
            puts e.backtrace
          end
        end
      end

      # => Sleep after all users are processed
      sleep(30.seconds)
    end
  end # task :track_time

  # if user deletes a task log on Harvest, the task doesn't pick it up
  # this task deletes from database all logs for today that aren't on Harvest
  task :reconcile_daily_logs => :environment do
    harvest_client  = get_harvest_client
    today_logs = []

    harvest_client.users.all.collect(&:id).each do |user_id|
      user_logs = harvest_client.time.all(Date.today, user_id)
      today_logs.concat(user_logs)
    end
    logs_from_trello = today_logs.select { |log| log.external_ref }

    HarvestLog.reconcile_daily_logs(Date.today, logs_from_trello)
  end # task :reconcile_daily_logs

end
