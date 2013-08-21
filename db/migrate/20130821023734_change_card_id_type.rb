class ChangeCardIdType < ActiveRecord::Migration
  def change
    change_column :estimations, :card_id, :string
 end
end
