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

class Ticket < ActiveRecord::Base
  belongs_to :ticket_group
  belongs_to :creator, :class_name => 'User'
  belongs_to :assignee, :foreign_key => "owner_id", :class_name => "User"
  has_many :comments

  validates :name, :presence => true
end
