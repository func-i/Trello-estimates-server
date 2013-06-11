class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :public_token
      t.string :secret_token

      t.timestamps
    end
  end
end
