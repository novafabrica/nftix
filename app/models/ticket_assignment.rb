# == Schema Information
#
# Table name: ticket_assignments
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class TicketAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
end
