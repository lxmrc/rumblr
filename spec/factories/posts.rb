FactoryBot.define do
  factory :post do
    title { "Example Post" }
    content { "This is an example of a post." }
    author { association :user }
  end
end
