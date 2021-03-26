FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.com" }
    sequence(:username) { |n| "user_#{n}" }
    password { "password" }
  end
end
