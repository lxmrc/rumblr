FactoryBot.define do
  factory :post do
    title { "Example Post" }
    body { "This is an example of a post." }
    author { association :user }
  end
end
