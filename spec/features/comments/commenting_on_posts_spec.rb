require "rails_helper"

RSpec.feature "Users can comment on posts", type: :feature do
  let(:author) { FactoryBot.create(:user) }
  let(:commenter) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, author: author) }

  before do
    login_as(commenter)
    visit user_path(author)
  end

  scenario "if they have something to say" do
    find("#comment-#{post.id}").click

    expect(page).to have_selector("#comment_content")

    fill_in "Say something nice:", with: "Great post!"
    click_on "Add Comment"

    expect(page).to have_content("Great post!")
  end

  scenario "but they can't say nothing" do
    find("#comment-#{post.id}").click

    expect(page).to have_selector("#comment_content")

    fill_in "Say something nice:", with: ""
    click_on "Add Comment"

    expect(page).to have_content("Content can't be blank")
  end
end
