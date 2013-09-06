class Tasks::HarvestLogImporter

  def initialize(task)
    @task = task
  end

  def perform
    puts "\n|-------------------------------------|"
    puts "Processing HarvestLog: \n#{@task.to_yaml}"
    puts "|-------------------------------------|\n"
    begin
      # => Find out if this Harvest Time entry was from an external source
      # => If it was, that means it came from Trello
      if @task.external_ref
        unless (harvest_trello = get_harvest_trello).blank?
          # => Populate the arguments for this HarvestLog to see if it's been created already
          # => TODO: Store the trello card name
          attrs = {
            time_spent: @task.hours,
            day: @task.spent_at,
            harvest_task_id: @task.task_id,
            harvest_task_name: @task.task,
            trello_card_id: @task.external_ref.id,
            developer_email: HARVEST.users.find(@task.user_id).email
          }

          # => Find the existing HarvestLog
          harvest_trello.harvest_logs.create!(attrs) unless HarvestLog.where(attrs).first
        end
      end
    rescue Exception => e
      # => Capture all exceptions while processing
      raise e.inspect
    end
  end

  def get_harvest_trello
    # => See if there is an association with the Harvest project and the Trello board
    harvest_trello = HarvestTrello.where(harvest_project_id: @task.project_id).first

    # => The harvest trello association doesn't exist, we need to create the harvest project -> trello board mapping
    unless harvest_trello

      # => Authenticate with trello
      auth_trello

      # => Load the trello card
      unless (trello_card = Trello::Card.find(@task.external_ref.id)).blank?

        # => Find the trello board from the board_id returned from the api call
        trello_board = Trello::Board.find trello_card.board_id

        # => Create the HarvestTrello mapping
        harvest_trello = HarvestTrello.create!(
          harvest_project_id: @task.project_id,
          harvest_project_name: @task.project,
          trello_board_id: trello_board.id,
          trello_board_name: trello_board.name
          ) if trello_board
      end
    end

    harvest_trello
  end

  def auth_trello
    Trello.configure do |config|
      config.developer_public_key = Figaro.env.trello_member_key
      config.member_token = Figaro.env.trello_token
    end
  end
end
