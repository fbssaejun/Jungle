require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should save successfully with all required fields" do
      @category = Category.new(name: "Snacks")
      @product = Product.new(name: "Potato Chips", price: 500, quantity: 5, category: @category)

      @product.save!

      expect(@product.id).to be_present
    end

    it "should not create product if name is NIL" do
      @category = Category.create(name: "Snacks")
      @product = Product.create(name: nil, price: 500, quantity: 5, category: @category)

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not create product if price is NIL" do
      @category = Category.create(name: "Snacks")
      @product = Product.create(name: "Potato Chips", price: nil, quantity: 5, category: @category)

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "should not create product if quantity is NIL" do
      @category = Category.create(name: "Snacks")
      @product = Product.create(name: "Potato Chips", price: 500, quantity: nil, category: @category)

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not create product if category is NIL" do
      @category = Category.create(name: "Snacks")
      @product = Product.create(name: "Potato Chips", price: 500, quantity: 5, category: nil)

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end


  end
end
