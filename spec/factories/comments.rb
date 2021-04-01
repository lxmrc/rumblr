FactoryBot.define do
  factory :comment do
    body { "MyText" }
    author { nil }
    post { nil }
  end
end
