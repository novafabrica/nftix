require 'spec_helper'

describe "ticket_groups/show" do
  before(:each) do
    @ticket_group = assign(:ticket_group, stub_model(TicketGroup,
      :name => "Name",
      :position => 1,
      :active => false,
      :ticket_count => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/2/)
  end
end
