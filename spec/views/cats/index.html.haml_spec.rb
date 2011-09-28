require 'spec_helper'

describe "cats/index.html.haml" do
  before(:each) do
    assign(:cats, [
      stub_model(Cat),
      stub_model(Cat)
    ])
  end

  it "renders a list of cats" do
    render
  end
end
