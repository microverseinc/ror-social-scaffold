FactoryBot.define do
  factory :user do
    name { 'Example User' }
    email { 'user@example.com' }
    encrypted_password { 'foobar' }
  end
end
