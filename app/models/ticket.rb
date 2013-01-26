class Ticket < ActiveRecord::Base
  belongs_to :ticket_group
  belongs_to :creator, :class_name => 'User'
  belongs_to :owner, :class_name => 'User'
end
