require 'spec_helper'

describe "ticket_groups/new" do
  before(:each) do
    assign(:ticket_group, stub_model(TicketGroup,
      :name => "MyString",
      :position => 1,
      :active => false,
      :ticket_count => 1
    ).as_new_record)
  end

  it "renders new ticket_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_groups_path, :method => "post" do
      assert_select "input#ticket_group_name", :name => "ticket_group[name]"
      assert_select "input#ticket_group_position", :name => "ticket_group[position]"
      assert_select "input#ticket_group_active", :name => "ticket_group[active]"
      assert_select "input#ticket_group_ticket_count", :name => "ticket_group[ticket_count]"
    end
  end
end
