namespace :harvest do
  task :track_time => :environment do
    while true
      HARVEST.users.all.collect(&:id).each do |user_id|
        puts "Processing user_id: #{user_id}"
        
        daily_tasks = HARVEST.time.all(Date.today, user_id).each do |daily_task_log|
          begin
            Tasks::HarvestLogImporter.new(daily_task_log).perform
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
