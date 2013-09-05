class CreateHarvestLogs < ActiveRecord::Migration
  def change
    create_table :harvest_logs do |t|
      t.string :harvest_project_name
      t.string :harvest_project_id

      t.string :harvest_task_name
      t.string :harvest_task_id

      t.string :trello_board_name
      t.string :trello_board_id

      t.string :trello_card_name
      t.string :trello_card_id

      t.float :time_spent
      t.string :developer_email
      t.date :day

      t.timestamps
    end
  end
end
