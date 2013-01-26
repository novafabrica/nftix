require 'spec_helper'

describe "ticket_groups/index" do
  before(:each) do
    assign(:ticket_groups, [
      stub_model(TicketGroup,
        :name => "Name",
        :position => 1,
        :active => false,
        :ticket_count => 2
      ),
      stub_model(TicketGroup,
        :name => "Name",
        :position => 1,
        :active => false,
        :ticket_count => 2
      )
    ])
  end

  it "renders a list of ticket_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
