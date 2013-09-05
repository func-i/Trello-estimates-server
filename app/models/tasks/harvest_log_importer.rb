class Tasks::HarvestLogImporter

  def self.new_entry(task)
    args = Hash.new
    args[:time_spent]           = task.hours
    args[:day]                  = task.spent_at
    args[:dev_email]            = HARVEST.users.find(task.user_id).email
    args[:harvest_project_name] = task.project
    args[:harvest_project_id]   = task.project_id
    args[:harvest_task_name]    = task.task
    args[:harvest_task_id]      = task.task_id
    args[:trello_card_id]       = task.external_ref.id

    if task.external_ref
      HarvestLog.create_or_update_harvest_log(args)
    end
  end
end
