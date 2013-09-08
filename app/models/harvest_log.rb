class HarvestLog < ActiveRecord::Base

  attr_accessible :day,
    :time_spent,
    :harvest_project_name,
    :harvest_project_id,
    :harvest_task_name,
    :harvest_task_id,
    :trello_board_name,
    :trello_board_id,
    :trello_card_name,
    :trello_card_id,
    :developer_email

  attr_accessor :harvest_project, :harvest_note

  belongs_to :harvest_trello

  # validates :board_id, :presence => true
  # validates :card_id, :presence => true
  # validates :developer_email, :presence => true
  # validates :total_time, :presence => true

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

  scope :time_tracked_by_card, lambda { |card_id|
    where("trello_card_id = ?", card_id).select("time_spent")
  }

end
