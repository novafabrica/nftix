class AccountController < ApplicationController
  before_action :confirm_logged_in

  def show
    tickets = @current_user.assigned_tickets
    @groups = tickets.group_by {|t| t.ticket_group}
  end

end
