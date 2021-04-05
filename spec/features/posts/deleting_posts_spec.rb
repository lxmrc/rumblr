require 'rails_helper'

RSpec.feature "Users can delete posts", type: :feature do
  let(:alice) { FactoryBot.create(:user) }
  let(:bob) { FactoryBot.create(:user) }

  let!(:post) { FactoryBot.create(:post, body: "I'm Alice.", author: alice) }

  scenario "that belong to them", js: true do
    login_as(alice)

    visit user_path(alice)
    accept_confirm do
      find("#delete-#{post.id}").click
    end

    expect(page).to_not have_content("I'm Alice.")
  end

  scenario "but not other users'" do
    login_as(bob)

    visit user_path(alice)

    expect(page).to_not have_selector("#delete-#{post.id}")
  end
end
