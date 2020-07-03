FactoryBot.define do
  factory :user, class: 'User' do
    id {1}
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :friend, class: 'User' do
    id {2}
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
