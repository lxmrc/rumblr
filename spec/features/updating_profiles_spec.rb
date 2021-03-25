require 'rails_helper'

RSpec.feature "Users can edit their profiles", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)

    visit user_path(user)
    click_link "Edit profile"
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
    expect(page.find('#profile-picture')['src']).to have_content 'test.png'
  end
end
