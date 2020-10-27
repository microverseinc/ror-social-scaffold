FactoryBot.define do
  factory :user do
    name { Faker::Name.name[1..20] }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
