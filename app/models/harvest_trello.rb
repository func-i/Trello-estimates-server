class HarvestTrello < ActiveRecord::Base

  attr_accessible :trello_board_name,
    :trello_board_id,
    :trello_card_name,
    :trello_card_short_id,
    :trello_card_long_id

  # validates :harvest_project,
  #           :presence => true

  validates :trello_board_id,
            :presence => true

  def self.find_or_create(long_id, short_id, card_name, board_name, board_id)
    if HarvestTrello.where(trello_card_long_id: long_id).first
      puts "<--- Database record already exists --->"
    else
      HarvestTrello.create!(
        trello_board_name: board_name,
        trello_board_id: board_id,
        trello_card_name: card_name,
        trello_card_short_id: short_id,
        trello_card_long_id: long_id)
    end
  end

end
