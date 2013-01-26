json.array!(@tickets) do |ticket|
  json.extract! ticket, :ticket_group_id, :owner_id, :assigned_user_id, :name, :description, :status, :due_date, :ticket_comment_count
  json.url ticket_url(ticket, format: :json)
end