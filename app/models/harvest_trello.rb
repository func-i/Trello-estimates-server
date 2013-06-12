class HarvestTrello < ActiveRecord::Base
  attr_accessible :harvest_project, :trello_board_id

  def self.board_by_harvest_project(harvest_project)
    where(:harvest_project => harvest_project).first
  end
end
