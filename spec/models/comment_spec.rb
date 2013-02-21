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

require 'spec_helper'

describe Comment do

  describe "after create" do

    it "sends an email to everyone in the ticket group by default" do
    @delay = PostOffice
    PostOffice.stub!(:delay).and_return(@delay)
    ticket_group = FactoryGirl.create(:ticket_group)
    user = FactoryGirl.create(:user,  :ticket_groups => [ticket_group])
    user2 = FactoryGirl.create(:user,  :ticket_groups => [ticket_group])
    commenter = FactoryGirl.create(:user, :ticket_groups => [ticket_group])
    ticket = FactoryGirl.create(:ticket, :ticket_group => ticket_group, :creator => user)
    comment = FactoryGirl.build(:comment, :ticket => ticket, :user => commenter)
    @delay.should_receive(:send_comment).with(ticket, comment, ticket.default_email_recipients(commenter))
    comment.save
    end

  end
end
