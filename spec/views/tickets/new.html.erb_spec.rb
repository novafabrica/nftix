require 'spec_helper'

describe "tickets/new" do
  before(:each) do
    assign(:ticket, stub_model(Ticket,
      :ticket_group_id => 1,
      :owner_id => 1,
      :assigned_user_id => 1,
      :name => "MyString",
      :description => "MyText",
      :status => "MyString",
      :ticket_comment_count => 1
    ).as_new_record)
  end

  it "renders new ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tickets_path, :method => "post" do
      assert_select "input#ticket_ticket_group_id", :name => "ticket[ticket_group_id]"
      assert_select "input#ticket_owner_id", :name => "ticket[owner_id]"
      assert_select "input#ticket_assigned_user_id", :name => "ticket[assigned_user_id]"
      assert_select "input#ticket_name", :name => "ticket[name]"
      assert_select "textarea#ticket_description", :name => "ticket[description]"
      assert_select "input#ticket_status", :name => "ticket[status]"
      assert_select "input#ticket_ticket_comment_count", :name => "ticket[ticket_comment_count]"
    end
  end
end
