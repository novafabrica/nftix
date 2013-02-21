# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  ticket_id  :integer
#  user_id    :integer
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base

  belongs_to :ticket
  belongs_to :user

  after_create :send_email

  def send_email
    PostOffice.delay.send_comment(ticket, self, ticket.default_email_recipients(user))
  end

end
