require 'spec_helper'

describe "tickets/edit" do
  before(:each) do
    @ticket = assign(:ticket, stub_model(Ticket,
      :ticket_group_id => 1,
      :owner_id => 1,
      :assigned_user_id => 1,
      :name => "MyString",
      :description => "MyText",
      :status => "MyString",
      :ticket_comment_count => 1
    ))
  end

  it "renders the edit ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tickets_path(@ticket), :method => "post" do
      assert_select "select#ticket_ticket_group_id", :name => "ticket[ticket_group_id]"
      assert_select "select#ticket_owner_id", :name => "ticket[owner_id]"
      assert_select "input#ticket_name", :name => "ticket[name]"
      assert_select "textarea#ticket_description", :name => "ticket[description]"
      assert_select "input#ticket_status", :name => "ticket[status]"
    end
  end
end
