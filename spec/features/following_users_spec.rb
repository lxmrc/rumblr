require 'rails_helper'

RSpec.feature "Users can follow and unfollow other users", type: :feature do
  let(:alice) { FactoryBot.create(:user, username: "Alice") }
  let(:bob) { FactoryBot.create(:user, username: "Bob") }
  let(:carol) { FactoryBot.create(:user, username: "Carol") }

  let!(:bob_post) { FactoryBot.create(:post, author: bob, content: "I'm Bob and this is my post.") }
  let!(:carol_post) { FactoryBot.create(:post, author: carol, content: "I'm Carol and this is my post.") }

  before do
    login_as(alice)
  end

  scenario "follow" do
    visit user_path(bob)

    expect(page).to have_content("0 followers")

    click_on "Follow"

    expect(page).to have_content("1 followers")
  end

  scenario "unfollow" do
    visit user_path(bob)

    expect(page).to have_content("0 followers")

    click_on "Follow"

    expect(page).to have_content("1 followers")

    click_on "Unfollow"

    expect(page).to have_content("0 followers")
  end
  
  scenario "and see their posts on their feed" do
    visit user_path(bob)
    click_on "Follow"
    visit user_feed_path

    expect(page).to have_content("I'm Bob and this is my post.")
    expect(page).to_not have_content("I'm Carol and this is my post.")
  end

  scenario "and see who other users follow and are followed by" do
    visit user_path(bob)
    click_on "Follow"
    visit following_user_path(alice)

    expect(page).to have_content("Bob")

    visit followers_user_path(bob)

    expect(page).to have_content("Alice")
  end
end
