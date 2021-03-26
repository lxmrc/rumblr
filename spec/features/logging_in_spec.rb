require 'rails_helper'

RSpec.feature "Users can sign up", type: :feature do
  let!(:user) { FactoryBot.create(:user, 
                                 email: "user@example.com", 
                                 username: "test user") }

  scenario "successfully" do
    visit root_path
    click_link "Log in"

    fill_in "Email", with: "user@example.com"
    fill_in "user_password", with: "password"
    click_button "Log in"

    expect(page).to have_content "Signed in successfully."
    expect(page).to have_content "test user"
    expect(page).to have_content "Edit profile"
    expect(page).to have_content "New Post"
    expect(page).to have_content "Profile"
    expect(page).to have_content "Log out"
  end
end
