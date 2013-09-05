class HarvestTrello < ActiveRecord::Base
  include Trello
  include Trello::Authorization

  attr_accessible :harvest_project,
                  :trello_board_id,
                  :project_name

  validates :harvest_project,
            :presence => true

  validates :trello_board_id,
            :presence => true

  def self.find_or_create(card_id, project_name, board_id)
    if HarvestTrello.find_by_harvest_project(card_id)
      puts "<--- Database record already exists --->"
    else
      HarvestTrello.create!(
        harvest_project: card_id,
        trello_board_id: board_id,
        project_name: project_name
      )
    end
  end

end

