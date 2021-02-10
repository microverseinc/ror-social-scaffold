FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    sequence(:email) { |n| "johndoe@ex#{n}.com" }
    password { 'secretpassword' }
  end
end
