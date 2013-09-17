namespace :harvest do
  task :track_time => :environment do
    while true
      HARVEST.users.all.collect(&:id).each do |user_id|

        # => Clear all their records every time.
        #HarvestLog.delete_all(user_id: user_id, day: Date.today)

        daily_tasks = HARVEST.time.all(Date.today, user_id).each do |daily_task_log|
          begin
            Tasks::HarvestLogImporter.new(daily_task_log).perform if daily_task_log.timer_started_at.blank?
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
