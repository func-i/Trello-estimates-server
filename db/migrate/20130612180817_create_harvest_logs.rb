class CreateHarvestLogs < ActiveRecord::Migration
  def change
    create_table :harvest_logs do |t|
      t.string :board_id
      t.integer :card_id
      t.float :total_time
      t.string :developer_email

      t.timestamps
    end
  end
end
