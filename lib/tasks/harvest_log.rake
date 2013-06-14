namespace :harvest do
  task :start_log_tracker => :environment do
    while true
      daily_tasks = HARVEST.time.all
      daily_tasks.each do |daily_task|
        begin
          developer_email = HARVEST.users.find(daily_task.user_id).email
          HarvestLog.create_or_update_log(daily_task.hours, daily_task.project, daily_task.notes, developer_email, daily_task.timer_started_at)
        rescue Exception => e
          puts e
        end
      end
      sleep(30.minutes)
    end
  end
end