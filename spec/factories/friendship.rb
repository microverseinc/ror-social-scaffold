FactoryGirl.define do
  factory :friendship do
    confirmed { Faker::Boolean.boolean }
  end
end
