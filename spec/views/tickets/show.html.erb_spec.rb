require 'spec_helper'

describe "tickets/show" do
  before(:each) do
    @ticket = assign(:ticket, stub_model(Ticket,
      :ticket_group_id => 1,
      :owner_id => 2,
      :creator_id => 3,
      :name => "Name",
      :description => "MyText",
      :status => "Status",
      :ticket_comment_count => 4
    ))
  end
  # todo: because we reach across the asociation for ticketgroup in the index view, we need to have that relation setup. 
  # it "renders attributes in <p>" do
  #   render
  #   # Run the generator again with the --webrat flag if you want to use webrat matchers
  #   rendered.should match(/1/)
  #   rendered.should match(/2/)
  #   rendered.should match(/Name/)
  #   rendered.should match(/MyText/)
  #   rendered.should match(/Status/)
  #   rendered.should match(/4/)
  # end
end
