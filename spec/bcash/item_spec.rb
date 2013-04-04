require 'spec_helper'

valid_attributes = {
	id: 1,
	description: "Description a item.",
	amount: 2,
	price: 200.00,
	integration: "PAD",
	tax: 10,
}

describe Bcash::Item do

	it "should be um valid item" do
		Bcash::Item.new(valid_attributes).should be_valid
	end

end
