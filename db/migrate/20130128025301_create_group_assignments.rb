class CreateGroupAssignments < ActiveRecord::Migration
  def change
    create_table :group_assignments do |t|
      t.references :ticket_group, :user
      t.timestamps
    end
    add_index :group_assignments, :user_id
    add_index :group_assignments, :ticket_group_id
    add_index :group_assignments, [:user_id, :ticket_group_id], :unique => true
  end
end
