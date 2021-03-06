require "rails_helper"

RSpec.feature "Users can log out", type: :feature do
  let!(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
    visit root_path
  end

  scenario "successfully" do
    click_link "Log out"

    expect(page).to have_content "Signed out successfully."
    expect(page).to_not have_content user.username
    expect(page).to_not have_link "New post"
    expect(page).to_not have_link "View profile"
    expect(page).to_not have_link "Edit profile"
    expect(page).to_not have_link "Log out"
  end
end
