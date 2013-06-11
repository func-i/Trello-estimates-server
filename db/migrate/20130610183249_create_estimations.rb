class CreateEstimations < ActiveRecord::Migration
  def change
    create_table :estimations do |t|
      t.float :developer_time
      t.float :manager_time
      t.string :user_email
      t.string :card_id
      t.string :board_id
      t.string :manager_id

      t.timestamps
    end
  end
end
