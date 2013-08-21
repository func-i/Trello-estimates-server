class ChangeCardIdHarvestLogs < ActiveRecord::Migration
  def change
    change_column :harvest_logs, :card_id, :string
  end
end
