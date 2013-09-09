namespace :harvest do
  task :track_time => :environment do
    while true
      daily_tasks = HARVEST.time.all(Date.today).each do |daily_task_log|
        begin
          Tasks::HarvestLogImporter.new(daily_task_log).perform
        rescue Exception => e
          puts e
          puts e.backtrace
        end
      end
      sleep(10.seconds)
    end
  end
end
