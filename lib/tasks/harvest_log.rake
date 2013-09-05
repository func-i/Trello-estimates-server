namespace :harvest do
  task :start_log_tracker => :environment do
    while true
      daily_tasks = HARVEST.time.all(Date.today)
      puts daily_tasks.inspect
      daily_tasks.select{|dt| dt.external_ref}.group_by{|dt| [dt.user_id, dt.external_ref.id]}.each do |daily_task_group|
        begin

          # Tasks::HarvestLogImporter.new_entry()

          daily_tasks = daily_task_group.last

          user_id = daily_task_group.first[0]
          trello_card_id = daily_task_group.first[1]
          daily_task = daily_tasks.first
          developer_email = HARVEST.users.find(daily_task.user_id).email

          if daily_task.external_ref
            HarvestLog.create_or_update_log(trello_card_id, daily_task.project_id, daily_task.project, daily_tasks.sum(&:hours), developer_email, daily_task.spent_at)
          end
        rescue Exception => e
          puts e
          puts e.backtrace
        end
      end
      sleep(10.seconds)
    end
  end
end
