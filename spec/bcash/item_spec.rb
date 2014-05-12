require 'spec_helper'

describe Bcash::Item do
  let(:valid_attributes) do
    {
      id: 1,
      description: "Description a item." * 100,
      amount: 2,
      price: 200.00,
    }
  end

  context 'when valid' do
    subject{ Bcash::Item.new(valid_attributes) }

    it 'object returns accpet to resquests' do
      expect(subject).to be_valid
    end

    it "returns description with at 255 caracters" do
      expect(subject.description.size).to eq(255)
    end
  end

end
