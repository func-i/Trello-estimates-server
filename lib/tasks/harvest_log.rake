require "harvested"

namespace :harvest do
  task :track_time => :environment do
    harvest_client = Harvest.hardy_client(
      subdomain:  Figaro.env.harvest_subdomain,
      username:   Figaro.env.harvest_username,
      password:   Figaro.env.harvest_password
    )

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
  end
end
