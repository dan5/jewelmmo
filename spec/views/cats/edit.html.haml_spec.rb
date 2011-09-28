require 'spec_helper'

describe "cats/edit.html.haml" do
  before(:each) do
    @cat = assign(:cat, stub_model(Cat))
  end

  it "renders the edit cat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cats_path(@cat), :method => "post" do
    end
  end
end
