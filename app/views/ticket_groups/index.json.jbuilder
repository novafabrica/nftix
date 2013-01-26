json.array!(@ticket_groups) do |ticket_group|
  json.extract! ticket_group, :name, :position, :active, :ticket_count
  json.url ticket_group_url(ticket_group, format: :json)
end