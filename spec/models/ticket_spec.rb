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

  describe "validation" do

    it "should be valid with a name and ticket group" do
      @ticket = FactoryGirl.build(:ticket)
      @ticket.valid?.should be_true
    end

    it "should be invalid without a name" do
      @ticket = FactoryGirl.build(:ticket, :name => "")
      @ticket.valid?.should be_false
      @ticket.errors[:name].should_not be_nil
    end

    it "should be invalid without a ticket_group" do
      @ticket = FactoryGirl.build(:ticket, :ticket_group_id => "")
      @ticket.valid?.should be_false
      @ticket.errors[:ticket_group].should_not be_nil
    end

  end

end
