class HarvestLog < ActiveRecord::Base
  attr_accessible :board_id,
    :card_id,
    :day,
    :developer_email,
    :total_time

  attr_accessor :harvest_project, :harvest_note

  #validates :board_id, :presence => true
  validates :card_id, :presence => true
  validates :developer_email, :presence => true
  validates :total_time, :presence => true

  scope :total_time_tracked, lambda { |board_id, card_id = nil|
    if card_id
      where("board_id = ? AND card_id = ?", board_id, card_id)
    else
      where("board_id = ?", board_id)
    end
  }

  scope :total_time_tracked_by_developer, lambda { |developer_email|
    where("developer_email = ?", developer_email)
  }

  def self.create_or_update_log(card_id, harvest_project_id, project_name, total_time, developer_email, day)
    # card_id = assigned_card(harvest_note)
    harvest_log = where(:card_id => card_id, :developer_email => developer_email, :day => day).first

    harvest_trello = HarvestTrello.find_or_create_by_harvest_project_and_project_name harvest_project_id, project_name
    if harvest_trello.trello_board_id.nil?
      board_id = fetch_board_id_from_trello_api(card_id)
      harvest_trello.update_attribute :trello_board_id, board_id
    end

    if harvest_log
      harvest_log.update_attribute("total_time", total_time) if harvest_log.total_time != total_time
    else
      HarvestLog.create!(
        card_id: card_id,
        day: day,
        developer_email: developer_email,
        total_time:  total_time,
        board_id: harvest_trello.board_id
      )
    end
  end

  private

    CARD_REGEX = /[C|c]ard ([0-9]+)/

    def self.assigned_card(text)
      CARD_REGEX.match(text)[1]
    end

    def self.fetch_board_id_from_trello_api(card_id)
      Trello.configure do |config|
        config.developer_public_key = Figaro.env.trello_member_key
        config.member_token = Figaro.env.trello_token
      end
      Trello::Card.find(card_id).board_id
    end
end
