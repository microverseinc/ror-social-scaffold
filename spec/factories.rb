FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test-#{n.to_s.rjust(3, '0')}" }
    email { "#{name}@example.com" }
    password { 'foobar' }
  end

  factory :post do
    content { 'Lorem ipsum' }
    user
  end
end

# sequence(:email) { |n| "test-#{n.to_s.rjust(3, '0')}@sample.com" }
