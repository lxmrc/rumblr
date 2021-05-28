FactoryBot.define do
  factory :comment do
    content { "This is a comment." }
    author { association :user }
    post
  end
end
