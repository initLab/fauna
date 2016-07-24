require "rails_helper"

RSpec.describe MembersFeesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/members_fees").to route_to("members_fees#index")
    end

    it "routes to #new" do
      expect(:get => "/members_fees/new").to route_to("members_fees#new")
    end

    it "routes to #show" do
      expect(:get => "/members_fees/1").to route_to("members_fees#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/members_fees/1/edit").to route_to("members_fees#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/members_fees").to route_to("members_fees#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/members_fees/1").to route_to("members_fees#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/members_fees/1").to route_to("members_fees#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/members_fees/1").to route_to("members_fees#destroy", :id => "1")
    end

  end
end
