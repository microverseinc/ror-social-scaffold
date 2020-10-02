FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.sentence }
  end
end
