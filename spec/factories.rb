FactoryBot.define do
  factory :friendship do
    user { nil }
    friend { nil }
    confirmed { false }
  end

  factory :user do
    sequence(:name) { |n| "test-#{n.to_s.rjust(3, '0')}" }
    email { "#{name}@example.com" }
    password { 'foobar' }
  end
end

# sequence(:email) { |n| "test-#{n.to_s.rjust(3, '0')}@sample.com" }