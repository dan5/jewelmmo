require "spec_helper"

describe CatsController do
  describe "routing" do

    it "routes to #index" do
      get("/cats").should route_to("cats#index")
    end

    it "routes to #new" do
      get("/cats/new").should route_to("cats#new")
    end

    it "routes to #show" do
      get("/cats/1").should route_to("cats#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cats/1/edit").should route_to("cats#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cats").should route_to("cats#create")
    end

    it "routes to #update" do
      put("/cats/1").should route_to("cats#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cats/1").should route_to("cats#destroy", :id => "1")
    end

  end
end
