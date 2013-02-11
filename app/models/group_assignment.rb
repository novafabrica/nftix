class GroupAssignment < ActiveRecord::Base

  belongs_to :ticket_group
  belongs_to :user

end
