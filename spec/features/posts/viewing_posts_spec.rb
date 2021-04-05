require 'rails_helper'

RSpec.feature "Users can see each posts", type: :feature do
  let(:alice) { FactoryBot.create(:user) }
  let(:bob) { FactoryBot.create(:user) }

  let!(:alice_post) { FactoryBot.create(:post, body: "I'm Alice.", author: alice) }
  let!(:bob_post) { FactoryBot.create(:post, body: "I'm Bob.", author: bob) }

  scenario "on profile pages" do
    visit user_path(alice)

    expect(page).to have_content("I'm Alice.")
    expect(page).to_not have_content("I'm Bob.")

    visit user_path(bob)

    expect(page).to have_content("I'm Bob.")
    expect(page).to_not have_content("I'm Alice.")
  end

  scenario "on individual post pages" do
    visit post_path(alice_post)

    expect(page).to have_content("I'm Alice.")
    expect(page).to_not have_content("I'm Bob.")

    visit post_path(bob_post)

    expect(page).to have_content("I'm Bob.")
    expect(page).to_not have_content("I'm Alice.")
  end
end
