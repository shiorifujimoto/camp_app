FactoryBot.define do
  factory :comment do
    comment  {Faker::Lorem.paragraph}
    association :user
    association :post
  end
end
