class CreateHarvestTrellos < ActiveRecord::Migration
  def change
    create_table :harvest_trellos do |t|
      t.string :trello_board_name
      t.string :trello_board_id
      t.string :trello_card_name
      t.string :trello_card_short_id
      t.string :trello_card_long_id

      t.timestamps
    end
  end
end
