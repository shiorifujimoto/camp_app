FactoryBot.define do
  factory :comment do
    comment {Faker::Lorem.sentence}
    association :user
    association :post
  end
end
