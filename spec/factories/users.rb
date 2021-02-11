FactoryBot.define do
  factory :user, aliases: %i[addressee requester] do
    name { 'John Doe' }
    sequence(:email) { |n| "johndoe@ex#{n}.com" }
    password { 'secretpassword' }
  end
end
