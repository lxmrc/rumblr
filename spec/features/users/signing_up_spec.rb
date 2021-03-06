require "rails_helper"

RSpec.feature "Users can sign up", type: :feature do
  before do
    visit root_path
    click_link "Sign up"
  end

  scenario "with valid input" do
    fill_in "Email", with: "user@example.com"
    fill_in "Username", with: "valid-username99"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content "Welcome! Complete your profile below."
    expect(page).to have_field("user[username]", with: "valid-username99")
    expect(page).to have_field "user[profile_picture]"
    expect(page).to have_field "user[bio]"

    expect(page).to have_link "New post"
    expect(page).to have_link "View profile"
    expect(page).to have_link "Edit profile"
    expect(page).to have_link "Log out"
  end

  scenario "with invalid email" do
    fill_in "Email", with: "not an email address"
    fill_in "Username", with: "valid-username99"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content "Email is invalid"
  end

  scenario "with missing email" do
    fill_in "Email", with: ""
    fill_in "Username", with: "valid-username99"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content "Email can't be blank"
  end

  scenario "with email already taken" do
    fill_in "Email", with: "user@example.com"
    fill_in "Username", with: "valid-username99"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    click_link "Log out"
    click_link "Sign up"

    fill_in "Email", with: "user@example.com"
    fill_in "Username", with: "different-username99"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content "Email has already been taken"
  end

  scenario "with special characters in username" do
    fill_in "Email", with: "user@example.com"
    fill_in "Username", with: "invalid @#$%^&* username"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content "Username is invalid"
  end

  scenario "with username longer than 32 characters" do
    fill_in "Email", with: "user@example.com"
    fill_in "Username", with: "usernamelongerthanthirtytwocharacters"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content "Username is too long (maximum is 32 characters)"
  end

  scenario "with username already taken" do
    fill_in "Email", with: "user@example.com"
    fill_in "Username", with: "valid-username99"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    click_link "Log out"
    click_link "Sign up"

    fill_in "Email", with: "different_user@example.com"
    fill_in "Username", with: "valid-username99"
    fill_in "Password", with: "password", match: :prefer_exact
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content "Username has already been taken"
  end
end
