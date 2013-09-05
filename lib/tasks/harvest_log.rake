namespace :harvest do
  task :start_log_tracker => :environment do
    while true
      daily_tasks = HARVEST.time.all(Date.today).each do |daily_task_log|
        begin
          Tasks::HarvestLogImporter.new_entry(daily_task_log)
        rescue Exception => e
          puts e
          puts e.backtrace
        end
      end
      sleep(10.seconds)
    end
  end
end
