FactoryBot.define do
  factory :friendship do
    user { nil }
    friend { nil }
    confirmed { false }
  end

  factory :user do
    name { 'Example User' }
    email { 'user@example.com' }
    encrypted_password { 'foobar' }
  end
end
