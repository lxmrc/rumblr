require "rails_helper"

RSpec.feature "Users can create posts", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user)
    visit user_path(user)
    click_link "New Post"
  end

  scenario "with title and body", js: true do
    fill_in "Title", with: "Test Post"
    fill_in_trix_editor "post_content", with: "This is a test post."
    click_button "Create Post"

    expect(page).to have_content("Test Post")
    expect(page).to have_content("This is a test post.")
  end

  scenario "without title", js: true do
    fill_in_trix_editor "post_content", with: "This is a post without a title."
    click_button "Create Post"

    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content("This is a post without a title.")
  end

  scenario "without body" do
    fill_in "Title", with: "This is a post without a body."
    click_button "Create Post"

    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content("This is a post without a body.")
  end

  scenario "without body or title" do
    click_button "Create Post"

    expect(page).to have_content("Content can't be blank")
    expect(page).to have_content("Title can't be blank")
    expect(page).to_not have_content("This is a post without a body.")
  end
end
