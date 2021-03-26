require 'rails_helper'

RSpec.feature "Users can sign up", type: :feature do
  scenario "successfully" do
    visit root_path
    click_link "Sign up"

    fill_in "Email", with: "user@example.com"
    fill_in "Username", with: "test user"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(page).to have_content "test user"
    expect(page).to have_content "Edit profile"
    expect(page).to have_content "New Post"
    expect(page).to have_content "Profile"
    expect(page).to have_content "Log out"
  end
end
