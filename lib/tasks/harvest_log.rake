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
        harvest_client.time.all(Date.today, user_id).each do |user_entry|
          begin
            # Harvest entries from external source => assume from Trello
            if user_entry.external_ref && user_entry.timer_started_at.blank?
              Tasks::HarvestLogImporter.new(harvest_client, user_entry).perform
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

  # if user deletes an entry on Harvest, the task above doesn't pick it up
  # this task deletes from database all entry logs for today that aren't on Harvest
  task :reconcile_daily_logs => :environment do
    harvest_client  = get_harvest_client
    today_entries   = []

    harvest_client.users.all.collect(&:id).each do |user_id|
      user_entries = harvest_client.time.all(Date.today, user_id)
      today_entries.concat(user_entries)
    end

    # Harvest entries from external source => assume from Trello
    entries_from_trello = today_entries.select { |entry| entry.external_ref }

    HarvestLog.reconcile_daily_logs(Date.today, entries_from_trello)
  end # task :reconcile_daily_logs

end
