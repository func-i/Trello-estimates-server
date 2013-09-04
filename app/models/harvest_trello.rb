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

  def self.board_from_project_id(project_id)
    result = self.where(:harvest_project => project_id).first.try :trello_board_id

    # board = @consumer.find(:cards, card_id)
    # puts "Testing variables: #{@consumer.inspect}"
    puts "board: #{result.inspect}"
  end
end
