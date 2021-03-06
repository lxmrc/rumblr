require "rails_helper"

RSpec.feature "Users can delete comments", type: :feature do
  let(:alice) { FactoryBot.create(:user) }
  let(:bob) { FactoryBot.create(:user) }
  let(:charlie) { FactoryBot.create(:user) }

  let!(:post) { FactoryBot.create(:post, author: alice) }
  let!(:comment) { FactoryBot.create(:comment, content: "Great post!", author: bob, post: post) }

  scenario "if the comment belongs to them", js: true do
    login_as(bob)
    visit post_path(post)

    expect(page).to have_content("This is an example of a post.")
    expect(page).to have_content("Great post!")

    accept_confirm do
      find("#delete-comment-#{comment.id}").click
    end

    expect(page).to have_content("This is an example of a post.")
    expect(page).to_not have_content("Great post!")
  end

  scenario "if the post belongs to them", js: true do
    login_as(alice)
    visit post_path(post)

    expect(page).to have_content("This is an example of a post.")
    expect(page).to have_content("Great post!")

    accept_confirm do
      find("#delete-comment-#{comment.id}").click
    end

    expect(page).to have_content("This is an example of a post.")
    expect(page).to_not have_content("Great post!")
  end

  scenario "but not if the comment doesn't belong to them" do
    login_as(charlie)
    visit post_path(post)

    expect(page).to_not have_selector("#delete-#{comment.id}")
  end
end
