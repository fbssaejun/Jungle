require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do

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

    scenario "They see product details after clicking on details button" do
      # ACT
      visit root_path
      first('a.pull-right').click()
  
      # DEBUG / VERIFY
      
      expect(page).to have_css 'section.products-show'
      save_screenshot
    end

end
