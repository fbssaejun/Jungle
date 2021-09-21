require 'rails_helper'

RSpec.feature "Adds item to cart and cart number increments", type: :feature, js: true do

    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'
  
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
    end

    scenario "cart size increases after clicking on add to cart button" do
      visit root_path
      save_screenshot
      page.find_button("Add").click
      save_screenshot
      expect(page).to have_content 'My Cart (1)'
    end

end
