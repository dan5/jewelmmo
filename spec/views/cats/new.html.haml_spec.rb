require 'spec_helper'

describe "cats/new.html.haml" do
  before(:each) do
    assign(:cat, stub_model(Cat).as_new_record)
  end

  it "renders new cat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cats_path, :method => "post" do
    end
  end
end
