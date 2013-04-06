module TicketsHelper

  def ticket_status_chooser(ticket, options={})
    actions = Ticket::STATUSES.map do |status|
      link_to(status, ticket_path(ticket, :ticket => {:status => status}), :method => :patch) if status !=ticket.status
    end
    options[:data] = options[:data].to_json
    options[:button_classes] ? options[:button_classes] += get_status_color(ticket.status)  : options[:button_classes] = get_status_color(ticket.status)
    split_button_group(ticket.status, actions, options).html_safe
  end

  def assignment_chooser(ticket, options={})
    actions = options[:data][:choices].map do |k, v|
      link_to(v, ticket_path(ticket, :ticket => {:owner_id =>  k }), :method => :patch)if ticket.owner_id != k
    end
    #TODO there must be a way to do this in split button
    options[:data] = options[:data].to_json
    split_button_group(ticket.assignee_name, actions, options).html_safe
  end

  def get_status_color(status)
    return ' btn-success' if status == 'open'
    return ' btn-info' if status == 'pending'
    return ' btn-success' if status == 'closed'
  end

end
