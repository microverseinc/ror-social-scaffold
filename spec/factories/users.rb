FactoryBot.define do
  factory :random_user, class: 'User' do
    id { 1 }
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :random_friend, class: 'User' do
    id { 2 }
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :random_user_list, class: 'User' do
    sequence(:id) { |n| n }
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
