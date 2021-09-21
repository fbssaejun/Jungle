require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

    # SETUP
    before :each do
      @user = User.create!(name:  "Anthony Kim", email:  "teSt@test.com", password:  "potato123", password_confirmation: "potato123")
    end

    scenario "when user logs in with correct credentials, redirects user to home page" do
      visit root_path
      find_link("Login").click
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      page.find_button("Submit").click

      expect(page).to have_content 'Signed in as ' + @user.name
      sleep 2
      save_screenshot
    end

end
