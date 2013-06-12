class CreateHarvestTrellos < ActiveRecord::Migration
  def change
    create_table :harvest_trellos do |t|
      t.string :harvest_project
      t.string :trello_board_id

      t.timestamps
    end
  end
end
