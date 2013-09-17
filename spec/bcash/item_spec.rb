require 'spec_helper'

valid_attributes = {
  id: 1,
  description: "Description a item.",
  amount: 2,
  price: 200.00,
}

describe Bcash::Item do

  it "should be a valid item" do
    Bcash::Item.new(valid_attributes).should be_valid
  end

  it "should be return description with at 255 caracters" do
    item = Bcash::Item.new(valid_attributes.merge(valid_attributes.merge(description: 'A' * 300)))
    item.description.size.should == 255
  end

end
