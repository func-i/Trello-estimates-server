class AddDayEntryIdToHarvestLogs < ActiveRecord::Migration
  def change
    add_column :harvest_logs, :harvest_entry_id, :integer
    add_index :harvest_logs, :harvest_entry_id
  end
end
