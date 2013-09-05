class HarvestLogImporter


end

# <Harvest::TimeEntry
#   client="sailias"
#   created_at="2013-09-05T16:33:17Z"
#   external_ref=<Harvest::TimeEntry
#     account_id="undefined"
#     day_entry_id=169463072
#     group_id="0nAKX1o5"
#     id="0nAKX1o5"
#     namespace="https://trello.com/c/0nAKX1o5"
#     service="trello.com"
#     service_icon="trello.com.png"
#     shorthand=nil>
#   hours=1.0
#   hours_without_timer=1.0
#   id=169463072
#   notes="Test 1"
#   project="Internal"
#   project_id="4064723"
#   spent_at=Thu, 05 Sep 2013
#   task="Admin"
#   task_id="2332994"
#   updated_at="2013-09-05T16:33:17Z"
#   user_id=569144>

# namespace :harvest do
#   task :start_log_tracker => :environment do
#     while true
#       daily_tasks = HARVEST.time.all(Date.today)
#       puts daily_tasks.to_yaml
#       daily_tasks.select{|dt| dt.external_ref}.group_by{|dt| [dt.user_id, dt.external_ref.id]}.each do |daily_task_group|
#         begin
#
#           Tasks::HarvestLogImporter.new_entry()
#
#           daily_tasks = daily_task_group.last
#
#           user_id = daily_task_group.first[0]
#           trello_card_id = daily_task_group.first[1]
#           daily_task = daily_tasks.first
#           developer_email = HARVEST.users.find(daily_task.user_id).email
#
#           if daily_task.external_ref
#             HarvestLog.create_or_update_log(trello_card_id, daily_task.project_id, daily_task.project, daily_tasks.sum(&:hours), developer_email, daily_task.spent_at)
#           end
#         rescue Exception => e
#           puts e
#           puts e.backtrace
#         end
#       end
#       sleep(10.seconds)
#     end
#   end
# end
