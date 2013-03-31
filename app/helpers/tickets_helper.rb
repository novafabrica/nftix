module TicketsHelper

  def ticket_status_chooser(ticket, options={})
    actions = Ticket::STATUSES.map do |status|
      link_to(status, ticket_path(ticket, :ticket => {:status => status}), :method => :patch) if status !=ticket.status
    end
    options[:data] = options[:data].to_json
    split_button_group(ticket.status, actions, options).html_safe
  end

  def assignment_chooser(ticket, options={})
    return unless ticket.assignee
    #TODO refactor not to call user per ticket
    actions = options[:data][:choices].map do |k, v|
      link_to(v, ticket_path(ticket, :ticket => {:owner_id =>  k }), :method => :patch)if ticket.owner_id != k
    end
    #TODO there must be a way to do this in split button
    options[:data] = options[:data].to_json
    split_button_group(ticket.assignee.full_name, actions, options).html_safe
  end

end
