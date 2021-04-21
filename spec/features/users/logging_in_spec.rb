require "rails_helper"

RSpec.feature "Users can log in", type: :feature do
  let!(:user) {
    FactoryBot.create(:user,
      email: "user@example.com",
      username: "test-user")
  }

  before do
    visit root_path
    click_link "Log in"
  end

  scenario "with valid details" do
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Log in"

    expect(page).to have_content "Signed in successfully."
    expect(page).to have_content user.username
    expect(page).to have_link "New post"
    expect(page).to have_link "View profile"
    expect(page).to have_link "Edit profile"
    expect(page).to have_link "Log out"
  end

  scenario "with invalid email" do
    fill_in "Email", with: "invalid_user@example.com"
    fill_in "Password", with: "password"
    click_button "Log in"

    expect(page).to have_content "Invalid Email or password."
  end

  scenario "with invalid password" do
    fill_in "Email", with: "user@example.com"
    fill_in "user_password", with: "incorrect password"
    click_button "Log in"

    expect(page).to have_content "Invalid Email or password."
  end
end
