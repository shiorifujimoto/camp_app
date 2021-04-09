FactoryBot.define do
  factory :post do

    title        {'大芝キャンプ場'}
    article_text {'大芝キャンプ場楽しかったです！'}
    status_id    {Faker::Number.within(range: 2..3)}
    category_id  {2}
    association  :user

    after(:build) do |post|
      post.images.attach(io: File.open('public/images/sample_image.png'), filename: 'sample_image.png')
    end
  end
end