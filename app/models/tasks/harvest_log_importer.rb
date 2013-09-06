class Tasks::HarvestLogImporter

  def self.new_entry(task)

    # => Find out if this Harvest Time entry was from an external source
    # => If it was, that means it came from Trello
    if task.external_ref

      # => Populate the arguments for this HarvestLog to see if it's been created already
      attrs = {
        time_spent: task.hours, 
        day: task.spent_at,
        harvest_project_id: task.project_id,
        harvest_task_id: task.task_id,
        trello_card_id: task.external_ref.id
      }

      # => Find the existing HarvestLog
      harvest_log = where(attrs).first

      # => If the log hasn't been created, we need to create one
      unless harvest_log

        # => Merge in the additional attributes for this HarvestLog
        attrs.merge!(
          dev_email: HARVEST.users.find(task.user_id).email,
          harvest_project_name: task.project,
          harvest_task_name: task.task
        )

        # => See if there is an association with the Harvest project and the Trello board
        harvest_trello = HarvestTrello.where(harvest_project_id: attrs[:harvest_project_id]).first

        # => The harvest trello association doesn't exist, we need to map the project to a board
        unless harvest_trello

        end 

      

          harvest_trello = fetch_trello_board_from_api(args[:trello_card_id])
        end

      end      
    end
  end

  def self.return_harvest_card(trello_card_id)
    unless trello_board_id
      Trello.configure do |config|
        config.developer_public_key = Figaro.env.trello_member_key
        config.member_token = Figaro.env.trello_token
      end
      Trello::Card.find(trello_card_id)
    end
  end 
end
