class HarvestTrello < ActiveRecord::Base
  attr_accessible :harvest_project,
                  :trello_board_id

  validates :harvest_project,
            :presence => true

  validates :trello_board_id,
            :presence => true

  def self.board_by_harvest_project(harvest_project)
    result = where(:harvest_project => harvest_project).first
    # binding.pry
    # result
  end

end
