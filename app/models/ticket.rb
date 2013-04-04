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
  belongs_to :ticket_group, :counter_cache => true
  belongs_to :creator, :class_name => 'User'
  belongs_to :assignee, :foreign_key => "owner_id", :class_name => "User"
  has_many :comments
  before_create :set_default_status

  validates :name, :presence => true
  validates :ticket_group_id, :presence => {:message => "Ticket must be assign to a Ticket Group"}
  #validates :owner_id, :presence => {:message => "You must assign a ticket to a user"}

  scope :in_progress, where(['tickets.status = ? OR tickets.status = ? ', 'open', 'pending'])
  scope :opened, where(:status => 'open')
  scope :pending_approval, where(:status => 'pending')
  scope :deleted, where(:status => 'deleted')


  STATUSES = ['open', 'closed', 'pending']

  def set_default_status
    self.status = 'open'
  end

  def assignee_name
    assignee ? assignee.full_name : "None"
  end

  def default_email_recipients(user = nil)
    ticket_group.users - [user]
  end

end
