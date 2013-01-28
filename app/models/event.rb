# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  ticket_id       :integer
#  ticket_group_id :integer
#  user_id         :integer
#  type            :string(255)
#  details         :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Event < ActiveRecord::Base
end
