require "rails_helper"

RSpec.feature "Users can edit their profiles", type: :feature do
  let(:user) { FactoryBot.create(:user, email: "user@example.com") }

  before do
    login_as(user)

    visit user_path(user)
    click_link "Edit profile"
  end

  scenario "email" do
    fill_in "Email", with: "different_email@example.com"
    click_button "Update Account"

    expect(page).to have_content "Your account has been updated successfully."

    visit edit_user_registration_path(user)
    expect(page).to have_field("Email", with: "different_email@example.com")
  end

  scenario "password" do
    fill_in "Current password", with: "password"
    fill_in "Password", with: "different password"
    fill_in "Password confirmation", with: "different password"
    click_button "Update Account"

    expect(page).to have_content "Your account has been updated successfully."

    click_link "Log out"
    click_link "Log in"

    fill_in "Email", with: "user@example.com"
    fill_in "user_password", with: "different password"
    click_button "Log in"

    expect(page).to have_content "Signed in successfully."
  end

  scenario "username" do
    fill_in "Username", with: "different-username"
    click_button "Update Account"

    expect(page).to have_content "Your account has been updated successfully."
    expect(page).to have_content "different-username"
  end

  scenario "bio" do
    fill_in "Bio", with: "I have a bio now."
    click_button "Update Account"

    expect(page).to have_content "Your account has been updated successfully."
    expect(page).to have_content "I have a bio now."
  end

  scenario "profile picture" do
    attach_file("Profile picture", Rails.root + "spec/fixtures/files/test.png")
    click_button "Update Account"

    expect(page).to have_content "Your account has been updated successfully."
    expect(page.find("#profile-picture")["src"]).to have_content "test.png"
  end
end
