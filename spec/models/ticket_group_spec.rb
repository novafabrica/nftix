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

require 'spec_helper'

describe TicketGroup do
  pending "add some examples to (or delete) #{__FILE__}"
end
