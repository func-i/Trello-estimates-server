class AddHarvestLogIndex < ActiveRecord::Migration

  def change
    add_index :harvest_logs, :harvest_trello_id
  end

end
