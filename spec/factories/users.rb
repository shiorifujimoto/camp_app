FactoryBot.define do
  
  factory :user do

    transient do
      person { Gimei.name }
    end

    nickname   {'キャンパー多田'}
    last_name  {person.last.kanji}
    first_name {person.first.kanji}
    email      {Faker::Internet.free_email}
    password   {'abc123'}
    password_confirmation       {password}
    profile    {'テストプロフィールです'}
  end
end
