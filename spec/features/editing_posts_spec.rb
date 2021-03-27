require 'rails_helper'

RSpec.feature "Users can edit posts", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, author: user) }

  before do
    login_as(user)
    visit user_path(user)
  end

  scenario "with valid attributes" do
    find("#edit-#{post.id}").click
    fill_in "Title", with: "Edited Post"
    fill_in "Body", with: "This post has been edited."
    click_button "Update Post"

    expect(page).to have_content "Edited Post"
    expect(page).to have_content "This post has been edited."
  end

  scenario "but body can't be blank" do
    find("#edit-#{post.id}").click
    fill_in "Body", with: ""
    click_button "Update Post"

    expect(page).to have_content "Body can't be blank"
  end
end
