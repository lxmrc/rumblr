require "rails_helper"

RSpec.feature "Users can see likes", type: :feature do
  let(:author) { FactoryBot.create(:user) }
  let(:liker) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, author: author) }
  let!(:like) { FactoryBot.create(:like, user: liker, post: post) }

  scenario "on a post's page" do
    visit post_path(post)

    expect(page).to have_content("#{liker} liked this.")
  end
end
