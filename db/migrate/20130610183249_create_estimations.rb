class CreateEstimations < ActiveRecord::Migration
  def change
    create_table :estimations do |t|
      t.float :user_time
      t.string :user_id
      t.integer :card_id
      t.string :board_id
      t.boolean :is_manager

      t.timestamps
    end
  end
end
