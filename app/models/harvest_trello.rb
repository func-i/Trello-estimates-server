class HarvestTrello < ActiveRecord::Base

  attr_accessible :harvest_project_id, 
    :harvest_project_name,
    :trello_board_name,
    :trello_board_id   

  # validates :harvest_project,
  #           :presence => true

  validates :trello_board_id,
            :presence => true

  has_many :harvest_logs
end
