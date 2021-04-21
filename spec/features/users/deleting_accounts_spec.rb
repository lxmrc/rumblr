require "rails_helper"

RSpec.feature "Users can delete their accounts", type: :feature do
  let!(:user) {
    FactoryBot.create(:user,
      email: "user@example.com",
      username: "test-user")
  }

  let!(:post) { FactoryBot.create(:post, author: user) }
  let!(:like) { FactoryBot.create(:like, user: user, post: post) }
  let!(:comment) { FactoryBot.create(:comment, author: user, post: post) }

  before do
    login_as(user)
  end

  scenario "successfully", js: true do
    visit edit_user_registration_path(user)
    accept_confirm do
      click_link "Delete my account"
    end

    expect(page).to have_content("Your account has been deleted.")

    click_button "Menu"
    click_link "Log in"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Log in"

    expect(page).to have_content "Invalid Email or password."
  end

  scenario "destroys likes and comments but not posts", js: true do
    visit post_path(post)

    expect(page).to have_content "test-user liked this."
    expect(page).to have_content "This is a comment."

    visit edit_user_registration_path(user)

    accept_confirm do
      click_link "Delete my account"
    end

    expect(page).to have_content("Your account has been deleted.")

    visit post_path(post)

    expect(page).to have_content "[deleted] posted"
    expect(page).to have_content "This is an example of a post."
    expect(page).to_not have_content "test-user liked this."
    expect(page).to_not have_content "This is a comment."
  end
end
