# == Schema Information
#
# Table name: ticket_groups
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  position     :integer
#  active       :boolean
#  ticket_count :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class TicketGroup < ActiveRecord::Base
  has_many :tickets
end
