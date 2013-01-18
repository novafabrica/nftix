class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :first_name, :last_name, :email, :hashed_password, :remember_token
      t.boolean :enabled
      t.datetime :remember_token_expires_at
      t.timestamps
    end
  end
end
