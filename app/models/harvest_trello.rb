class HarvestTrello < ActiveRecord::Base

  has_many :harvest_logs

  validates :trello_board_id,      presence: true
  validates :trello_board_name,    presence: true
  validates :harvest_project_id,   presence: true
  validates :harvest_project_name, presence: true

end
