class CreateTicketAssignments < ActiveRecord::Migration
  def change
    create_table :ticket_assignments do |t|
      t.references :user, :ticket
      t.timestamps
    end
    add_index :ticket_assignments, :ticket_id
    add_index :ticket_assignments, :user_id
    add_index :ticket_assignments, [:ticket_id, :user_id], :unique => true
  end
end
