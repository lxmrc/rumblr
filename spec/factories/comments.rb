FactoryBot.define do
  factory :comment do
    body { "This is a comment." }
    author { association :user }
    post
  end
end
