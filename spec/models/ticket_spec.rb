# == Schema Information
#
# Table name: tickets
#
#  id              :integer          not null, primary key
#  ticket_group_id :integer
#  creator_id      :integer
#  owner_id        :integer
#  name            :string(255)
#  description     :text
#  status          :string(255)
#  due_date        :datetime
#  comment_count   :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Ticket do
  pending "add some examples to (or delete) #{__FILE__}"
end
