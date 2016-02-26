class Tasks::HarvestLogImporter
  include TrelloParseHelper

  def initialize(harvest_client, entry)
    @harvest_client = harvest_client
    @entry = entry
  end

  def perform
    begin
      unless (harvest_trello = get_harvest_trello).blank?
        # => Populate the arguments for this HarvestLog to see if it's been created already

        attrs = {
          time_spent: @entry.hours,
          day: @entry.spent_at,
          harvest_task_id: @entry.task_id,
          harvest_task_name: @entry.task,
          trello_card_id: @entry.external_ref.id,
          trello_card_name: @entry.notes,
          developer_email: @harvest_client.users.find(@entry.user_id).email
        }

        # => Find the existing HarvestLog
        if harvest_log = harvest_trello.harvest_logs.where(harvest_entry_id: @entry.id).first
          harvest_log.update_attribute(:time_spent, @entry.hours)
        else
          harvest_trello.harvest_logs.create!(attrs.merge!(harvest_entry_id: @entry.id))
        end
      end
    rescue Exception => e
      # => Capture all exceptions while processing
      raise e.inspect
    end
  end

  def get_harvest_trello
    # => See if there is an association with the Harvest project and the Trello board
    harvest_trello = HarvestTrello.where(harvest_project_id: @entry.project_id).first

    # => The harvest trello association doesn't exist, we need to create the harvest project -> trello board mapping
    unless harvest_trello

      # => Authenticate with trello
      auth_trello

      # => Load the trello card
      unless (trello_card = Trello::Card.find(@entry.external_ref.id)).blank?

        # => Find the trello board from the board_id returned from the api call
        trello_board = Trello::Board.find trello_card.board_id

        # => Create the HarvestTrello mapping
        harvest_trello = HarvestTrello.create!(
          harvest_project_id: @entry.project_id,
          harvest_project_name: @entry.project,
          trello_board_id: parse_short_link(trello_board.url),
          trello_board_name: trello_board.name
          ) if trello_board
      end
    end

    harvest_trello
  end

  def auth_trello
    Trello.configure do |config|
      config.developer_public_key = Figaro.env.trello_developer_key
      config.member_token = Figaro.env.trello_token
    end
  end
end
