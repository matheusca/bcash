module Bcash
  class Item
    include ActiveModel::Validations

    attr_accessor :id, :description, :amount, :price, :integration, :shipping_cost

    validates_presence_of :id, :description, :amount, :price
    validate :quantity_amount

    def initialize(attributes={})
      @id = attributes[:id]
      @description = attributes[:description]
      @amount = attributes[:amount]
      @price = attributes[:price]
    end


    def description
      @description[0..254] if @description.present?
    end

    protected

    def quantity_amount
      errors.add(:quantity, " must be a number between 1 and 99999999999") if @quantity.present? && (@quantity == 0 || @quantity.to_s !~ /^\d{1,11}$/)
    end

  end
end
