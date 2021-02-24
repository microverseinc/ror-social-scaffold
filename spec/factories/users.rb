FactoryBot.define do
    factory :user, aliases: %i[receiver requester] do
      name { 'John' }
      sequence(:email) { |n| "john@ex#{n}.com" }
      password { 'password' }
    end
  end