FactoryGirl.define do
  factory :post do
    content { Faker::Lorem.paragraph }
  end
end
