require 'spec_helper'

describe Recipe do
  it "should require a name" do 
    recipe = Recipe.new(name:nil)
    expect(recipe).to be_invalid
  end
end
