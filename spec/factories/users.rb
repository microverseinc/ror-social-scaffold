FactoryBot.define do
  factory :user do
    name { Faker::Name.name[0..19] }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
