require "rails_helper"

RSpec.feature "Users can edit posts", type: :feature do
  let(:alice) { FactoryBot.create(:user) }
  let(:bob) { FactoryBot.create(:user) }

  let!(:alice_post) { FactoryBot.create(:post, author: alice) }
  let!(:bob_post) { FactoryBot.create(:post, author: bob) }

  before do
    login_as(alice)
    visit user_path(alice)
  end

  scenario "with title and body", js: true do
    find("#edit-#{alice_post.id}").click
    fill_in "Title", with: "Edited Post"
    fill_in "Content", with: "This post has been edited."
    click_button "Update Post"

    expect(page).to have_content "Edited Post"
    expect(page).to have_content "This post has been edited."
  end

  scenario "without title", js: true do
    find("#edit-#{alice_post.id}").click
    fill_in "Content", with: "This is a post without a title."
    click_button "Update Post"

    expect(page).to have_content "This is a post without a title."
  end

  scenario "without body" do
    find("#edit-#{alice_post.id}").click
    fill_in "Title", with: "This is a post without a body."
    click_button "Update Post"

    expect(page).to have_content "This is a post without a body."
  end

  scenario "without body or title" do
    find("#edit-#{alice_post.id}").click
    fill_in "Title", with: ""
    fill_in "Content", with: ""
    click_button "Update Post"

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Content can't be blank"
  end

  scenario "unless they don't belong them" do
    visit user_path(bob)

    expect(page).to_not have_select("#edit-#{bob_post.id}")

    visit edit_post_path(bob_post)

    expect(page).to have_content "That doesn't belong to you."
    expect(page).to_not have_field("Title")
    expect(page).to_not have_field("Body")
  end
end
