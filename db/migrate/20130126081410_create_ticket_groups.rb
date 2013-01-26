class CreateTicketGroups < ActiveRecord::Migration
  def change
    create_table :ticket_groups do |t|
      t.string :name
      t.integer :position
      t.boolean :active
      t.integer :ticket_count

      t.timestamps
    end
  end
end
