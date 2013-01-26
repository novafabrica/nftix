class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :ticket_group_id
      t.integer :creator_id
      t.integer :owner_id
      t.string :name
      t.text :description
      t.string :status
      t.datetime :due_date
      t.integer :comment_count

      t.timestamps
    end
  end
end
