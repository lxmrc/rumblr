require 'rails_helper'

RSpec.feature "Users can edit posts", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  let!(:post) { FactoryBot.create(:post, author: user) }
  let!(:other_post) { FactoryBot.create(:post, author: other_user) }

  before do
    login_as(user)
    visit user_path(user)
  end

  scenario "with title and body" do
    find("#edit-#{post.id}").click
    fill_in "Title", with: "Edited Post"
    fill_in "Body", with: "This post has been edited."
    click_button "Update Post"

    expect(page).to have_content "Edited Post"
    expect(page).to have_content "This post has been edited."
  end

  scenario "without title" do
    find("#edit-#{post.id}").click
    fill_in "Body", with: "This is a post without a title."
    click_button "Update Post"

    expect(page).to have_content "This is a post without a title."
  end

  scenario "without body" do
    find("#edit-#{post.id}").click
    fill_in "Title", with: "This is a post without a body."
    click_button "Update Post"

    expect(page).to have_content "This is a post without a body."
  end

  scenario "unless they don't belong them" do
    visit user_path(other_user)

    expect(page).to_not have_select("#edit-#{other_post.id}")

    visit edit_post_path(other_post)

    expect(page).to have_content "That doesn't belong to you."
    expect(page).to_not have_field("Title")
    expect(page).to_not have_field("Body")
  end
end
