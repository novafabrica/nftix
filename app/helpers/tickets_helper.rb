module TicketsHelper
  def ticket_status_chooser(ticket, options={})
    actions = Ticket::STATUSES.map do |status|
      link_to(status, ticket_path(ticket, :ticket => {:status => status}), :method => :patch) if status !=ticket.status
    end
    split_button_group(ticket.status, actions, options).html_safe
  end
end
