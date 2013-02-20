module ApplicationHelper

  def ticket_group_chooser(user, options={})
    return '' unless user
    current_ticket_group = TicketGroup.where(:id => session[:ticket_group]).first || user.ticket_groups.first
    return '' unless current_ticket_group
    active_link = link_to current_ticket_group.name, ticket_group_path(current_ticket_group)
    links = user.ticket_groups.map {|g| link_to(g.name, ticket_group_path(g, :set_cookie => true))}
    split_button_group(active_link, links)
  end

  def split_button_group(active_link, actions=[], options={})
    html = ""
    html << "<div class='btn-group #{options[:classes]}'>"
    html << '<button class="btn">'
    html << active_link
    html << '</button>'
    html << '<button class="btn dropdown-toggle" data-toggle="dropdown">'
    html << '<span class="caret"></span>'
    html << '</button>'
    html << '<ul class="dropdown-menu">'
    for action in actions
      html << "<li>#{action}</li>"
    end
    html << '</ul>'
    html << '</div>'
  end
end
