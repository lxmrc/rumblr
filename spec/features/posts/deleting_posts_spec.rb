require "rails_helper"

RSpec.feature "Users can delete posts", type: :feature do
  let(:alice) { FactoryBot.create(:user) }
  let(:bob) { FactoryBot.create(:user) }

  let!(:post) { FactoryBot.create(:post, content: "I'm Alice.", author: alice) }

  scenario "that belong to them", js: true do
    login_as(alice)

    visit user_path(alice)

    expect(page).to have_content("I'm Alice.")

    accept_confirm do
      find("#delete-#{post.id}").click
    end

    sleep(1)

    visit user_path(alice)

    expect(page).to_not have_content("I'm Alice.")
  end

  scenario "but not other users'" do
    login_as(bob)

    visit user_path(alice)

    expect(page).to_not have_selector("#delete-#{post.id}")
  end
end
