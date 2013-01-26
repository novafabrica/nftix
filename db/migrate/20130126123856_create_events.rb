class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :ticket_id
      t.integer :ticket_group_id
      t.integer :user_id
      t.string :type
      t.string :details

      t.timestamps
    end
  end
end
