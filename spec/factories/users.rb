FactoryBot.define do
  factory :user, class: User do
    name { Faker::Internet.unique.username }
    email { Faker::Internet.unique.email }
    password { 123_456 }
  end
end
