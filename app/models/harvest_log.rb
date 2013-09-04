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

  def self.create_or_update_log(card_id, total_time, developer_email, day)
    # card_id = assigned_card(harvest_note)
    # board_id = HarvestTrello.board_by_harvest_project(project_id)
    puts "\n"
    puts "Inside HarvestLog.create_or_update_log, trello card: #{card_id}\n"
    puts "\n"

    harvest_log = where(:card_id => card_id, :developer_email => developer_email, :day => day).first

    if harvest_log
      harvest_log.update_attribute("total_time", total_time) if harvest_log.total_time != total_time
    else
      HarvestLog.create!(
        card_id: card_id,
        day: day,
        developer_email: developer_email,
        total_time:  total_time
      )
    end
  end

  private

  CARD_REGEX = /[C|c]ard ([0-9]+)/

  def self.assigned_card(text)
    CARD_REGEX.match(text)[1]
  end
end
