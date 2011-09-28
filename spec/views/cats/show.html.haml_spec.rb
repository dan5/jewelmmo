require 'spec_helper'

describe "cats/show.html.haml" do
  before(:each) do
    @cat = assign(:cat, stub_model(Cat))
  end

  it "renders attributes in <p>" do
    render
  end
end
