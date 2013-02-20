module TicketsHelper

  def ticket_status_chooser(ticket, options={})
    actions = Ticket::STATUSES.map do |status|
      link_to(status, ticket_path(ticket, :ticket => {:status => status}), :method => :patch) if status !=ticket.status
    end
    split_button_group(ticket.status, actions, options).html_safe
  end

  def assignment_chooser(ticket, options={})
    #TODO refactor not to call user per ticket
    actions = User.all.map do |u|
      u.full_name if ticket.assignee != u
    end
    split_button_group(ticket.assignee.full_name, actions, options).html_safe
  end

end
