FactoryBot.define do
  factory :user do
    name { Faker::Name.name[0...20] }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
