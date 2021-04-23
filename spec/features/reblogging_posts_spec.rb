require 'rails_helper'

RSpec.feature "Users can reblog posts", type: :feature do
  let(:author) { FactoryBot.create(:user) }
  let(:reblogger) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, author: author) }

  before do
    login_as(reblogger)
    visit post_path(post)
  end

  scenario "and add additional content" do
    expect(page).to have_content "0 notes"

    find("#reblog-#{post.id}").click
    fill_in "post_content", with: "I'm reblogging this post."
    click_on "Reblog"

    expect(page).to have_content "I'm reblogging this post."
    expect(page).to have_content "1 note"
  end

  scenario "without adding additional content" do
    expect(page).to have_content "0 notes"

    find("#reblog-#{post.id}").click
    fill_in "post_content", with: "I'm reblogging this post."
    click_on "Reblog"

    expect(page).to have_content "I'm reblogging this post."
    expect(page).to have_content "1 note"
  end

  scenario "and create separate threads" do
    find("#reblog-#{post.id}").click
    fill_in "post_content", with: "This is reblog thread A."
    click_on "Reblog"

    visit post_path(post)
    find("#reblog-#{post.id}").click
    fill_in "post_content", with: "This is reblog thread B."
    click_on "Reblog"

    within "#thread" do
      expect(page).to have_content "This is reblog thread B."
      expect(page).to_not have_content "This is reblog thread A."
    end
  end
end
