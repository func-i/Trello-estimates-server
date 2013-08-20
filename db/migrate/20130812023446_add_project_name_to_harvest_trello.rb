class AddProjectNameToHarvestTrello < ActiveRecord::Migration
  def change
    add_column :harvest_trellos, :project_name, :string
  end
end
