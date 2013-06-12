class HarvestLog < ActiveRecord::Base
  attr_accessible :board_id,
                  :card_id,
                  :developer_email,
                  :total_time

  attr_accessor :harvest_project,
                :harvest_note

  def self.create_or_update_log(total_time, harvest_project, harvest_note, developer_email)
    card_id = assigned_card(harvest_note)
    board_id = HarvestTrello.board_by_harvest_project(harvest_project).trello_board_id
    log_on_db = HarvestLog.by_triple(board_id, card_id, developer_email)

    harvest_log = if log_on_db.class == HarvestLog
                    log_on_db
                  else
                    HarvestLog.new(
                        :board_id => board_id,
                        :card_id => card_id,
                        :developer_email => developer_email,
                        :total_time => total_time
                    )

                  end

    harvest_log.save if harvest_log.new_record? || harvest_log.total_time != total_time

    harvest_log
  end

  private
  CARD_REGEX = /card ([0-9]+)/

  def self.assigned_card(text)
    CARD_REGEX.match(text)[1]
  end

  def self.by_triple (board_id, card_id, developer_email)
    where(:board_id => board_id, :card_id => card_id, :developer_email => developer_email).first
  end
end
