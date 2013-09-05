class HarvestTrello < ActiveRecord::Base

  attr_accessible :harvest_project,
                  :trello_board_id,
                  :project_name

  validates :harvest_project,
            :presence => true

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
        trello_card_long_id: long_id
      )
    end
  end

end
# create_table "harvest_trellos", :force => true do |t|
#   t.string   "trello_board_name"
#   t.string   "trello_board_id"
#   t.string   "trello_card_name"
#   t.string   "trello_card_short_id"
#   t.string   "trello_card_long_id"
#   t.datetime "created_at",           :null => false
#   t.datetime "updated_at",           :null => false
# end

