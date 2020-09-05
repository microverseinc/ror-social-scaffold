FactoryBot.define do
  factory :user, aliases: %i[receiver sender] do
    name { 'username' }
    email { 'email@web.com' }
    password { 'password' }
  end
end
