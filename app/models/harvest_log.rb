class HarvestLog < ActiveRecord::Base
  attr_accessible :board_id,
                  :card_id,
                  :day,
                  :developer_email,
                  :total_time

  attr_accessor :harvest_project,
                :harvest_note

  validates :board_id,
            :presence => true

  validates :card_id,
            :presence => true

  validates :developer_email,
            :presence => true

  validates :total_time,
            :presence => true

  scope :total_time_tracked, lambda { |board_id, card_id = nil|
    if card_id
      where(:board_id => board_id, :card_id => card_id)
    else
      where(:board_id => board_id)
    end
  }

  def self.create_or_update_log(total_time, harvest_project, harvest_note, developer_email, day)
    card_id = assigned_card(harvest_note)
    board_id = HarvestTrello.board_by_harvest_project(harvest_project).trello_board_id

    log_on_db = where(:board_id => board_id, :card_id => card_id, :developer_email => developer_email, :day => day)

    harvest_log = if log_on_db.count > 0
                    log_on_db = log_on_db.first
                    log_on_db.total_time = total_time if  log_on_db.total_time != total_time
                    log_on_db
                  else
                    HarvestLog.new(
                        :board_id => board_id,
                        :card_id => card_id,
                        :day => day,
                        :developer_email => developer_email,
                        :total_time => total_time
                    )

                  end

    harvest_log.save

    harvest_log
  end

  private
  CARD_REGEX = /[C|c]ard ([0-9]+)/

  def self.assigned_card(text)
    CARD_REGEX.match(text)[1]
  end
end
