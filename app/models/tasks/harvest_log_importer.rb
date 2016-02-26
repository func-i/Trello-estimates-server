class Tasks::HarvestLogImporter
  include TrelloParseHelper

  def initialize(harvest_client, entry)
    @entry = entry
    @harvest_client = harvest_client
    @harvest_trello = get_harvest_trello
  end

  def perform
    begin
      harvest_log = @harvest_trello.harvest_logs.find_by(harvest_entry_id: @entry.id)
      # Update the HarvestLog if it already exists
      if harvest_log.present?
        harvest_log.update!(:time_spent, @entry.hours)
      else
        # Create the HarvestLog if it doesn't exist
        create_harvest_log
      end

    rescue Exception => e
      raise e.inspect
    end
  end

  private

  def get_harvest_trello
    begin
      # Find association between Harvest project and Trello board
      harvest_trello = HarvestTrello.find_by(harvest_project_id: @entry.project_id)
      return harvest_trello if harvest_trello.present?

      # Create association of Harvest project to Trello board if it doesn't exist
      authenticate_trello
      trello_card   = Trello::Card.find @entry.external_ref.id
      trello_board  = Trello::Board.find trello_card.board_id
      create_harvest_trello(trello_board)

    rescue Exception => e
      raise e.inspect
    end
  end

  def authenticate_trello
    Trello.configure do |config|
      config.developer_public_key = Figaro.env.trello_developer_key
      config.member_token = Figaro.env.trello_token
    end
  end

  def create_harvest_log
    @harvest_trello.harvest_logs.create!(
      harvest_entry_id:   @entry.id,
      harvest_task_id:    @entry.task_id,
      harvest_task_name:  @entry.task,
      trello_card_id:   @entry.external_ref.id,
      trello_card_name: @entry.notes,
      day:        @entry.spent_at,
      time_spent: @entry.hours,
      developer_email: @harvest_client.users.find(@entry.user_id).email
    )
  end

  def create_harvest_trello(trello_board)
    HarvestTrello.create!(
      harvest_project_id:   @entry.project_id,
      harvest_project_name: @entry.project,
      trello_board_id:    parse_short_link(trello_board.url),
      trello_board_name:  trello_board.name
    )
  end

end
