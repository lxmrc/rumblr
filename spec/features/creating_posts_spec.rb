require 'rails_helper'

RSpec.feature "Users can create posts", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)

    visit root_path
    click_link "New Post"
  end

  scenario "with title and body" do
    fill_in "Title", with: "Test Post"
    fill_in "Body", with: "This is a test post."
    click_button "Create Post"

    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content("Test Post")
    expect(page).to have_content("This is a test post.")
  end

  scenario "without title" do
    fill_in "Body", with: "This is a post without a title."
    click_button "Create Post"

    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content("This is a post without a title.")
  end

  scenario "without body" do
    fill_in "Title", with: "This is a post without a body."
    click_button "Create Post"

    expect(page).to have_content("Body can't be blank")
    expect(page).to_not have_content("This is a post without a body.")
  end
end
