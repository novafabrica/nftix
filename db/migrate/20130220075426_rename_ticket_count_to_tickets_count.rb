class RenameTicketCountToTicketsCount < ActiveRecord::Migration
  def change
    rename_column :ticket_groups, :ticket_count, :tickets_count
  end
end
