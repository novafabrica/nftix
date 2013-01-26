require "spec_helper"

describe TicketGroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/ticket_groups").should route_to("ticket_groups#index")
    end

    it "routes to #new" do
      get("/ticket_groups/new").should route_to("ticket_groups#new")
    end

    it "routes to #show" do
      get("/ticket_groups/1").should route_to("ticket_groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ticket_groups/1/edit").should route_to("ticket_groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ticket_groups").should route_to("ticket_groups#create")
    end

    it "routes to #update" do
      put("/ticket_groups/1").should route_to("ticket_groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ticket_groups/1").should route_to("ticket_groups#destroy", :id => "1")
    end

  end
end
