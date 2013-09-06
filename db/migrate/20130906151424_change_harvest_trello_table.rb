class ChangeHarvestTrelloTable < ActiveRecord::Migration
  def change    
    remove_column :harvest_trellos, :trello_card_name
    remove_column :harvest_trellos, :trello_card_short_id
    remove_column :harvest_trellos, :trello_card_long_id

    remove_column :harvest_logs, :harvest_project_name
    remove_column :harvest_logs, :harvest_project_id
    remove_column :harvest_logs, :trello_board_name
    remove_column :harvest_logs, :trello_board_id

    add_column :harvest_logs, :harvest_trello_id, :integer

    add_column :harvest_trellos, :harvest_project_id, :string
    add_column :harvest_trellos, :harvest_project_name, :string    

    #add_column :harvest_trellos, :trello_board_id, :integer
    #add_column :harvest_trellos, :trello_board_name, :string

    add_index :harvest_trellos, :harvest_project_id
    add_index :harvest_trellos, :trello_board_id
  end
end