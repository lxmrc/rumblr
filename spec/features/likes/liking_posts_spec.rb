require "rails_helper"

RSpec.feature "Users can like posts and unlike posts", type: :feature do
  let(:author) { FactoryBot.create(:user) }
  let(:liker) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, author: author) }

  before do
    login_as(liker)
    visit user_path(author)
  end

  scenario "if they like them", js: true do
    notes = find(:css, "#notes-#{post.id}")

    expect(notes).to have_content("0 notes")

    find("#like-#{post.id}").click

    expect(notes).to have_content("1 note")
    expect(page).not_to have_selector("#like-#{post.id}")
    expect(page).to have_selector("#unlike-#{post.id}")

    find("#unlike-#{post.id}").click

    expect(notes).to have_content("0 notes")
    expect(page).not_to have_selector("#unlike-#{post.id}")
    expect(page).to have_selector("#like-#{post.id}")
  end
end
