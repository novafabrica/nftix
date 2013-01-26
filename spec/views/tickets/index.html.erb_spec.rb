require 'spec_helper'

describe "tickets/index" do
  before(:each) do
    assign(:tickets, [
      stub_model(Ticket,
        :ticket_group_id => 1,
        :owner_id => 2,
        :assigned_user_id => 3,
        :name => "Name",
        :description => "MyText",
        :status => "Status",
        :ticket_comment_count => 4
      ),
      stub_model(Ticket,
        :ticket_group_id => 1,
        :owner_id => 2,
        :assigned_user_id => 3,
        :name => "Name",
        :description => "MyText",
        :status => "Status",
        :ticket_comment_count => 4
      )
    ])
  end

  it "renders a list of tickets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
