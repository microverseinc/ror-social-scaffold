FactoryBot.define do

  factory :user, aliases: [:receiver, :sender] do
    name { 'username' }
    email {'email@web.com'}
    password {'password'}
  end
end
