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
    :developer_email,
    :harvest_entry_id

  belongs_to :harvest_trello

  validates :harvest_task_name, :presence => true
  validates :harvest_task_id,   :presence => true
  validates :trello_card_id,    :presence => true
  validates :time_spent,        :presence => true
  validates :day,               :presence => true
  validates :developer_email,   :presence => true
  validates :trello_card_name,  :presence => true

  scope :time_tracked_by_card, lambda { |card_id|
    where("trello_card_id = ?", card_id)
  }

end
