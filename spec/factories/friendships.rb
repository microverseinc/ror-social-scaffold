FactoryBot.define do
  factory :friendship, class: Friendship do
    trait :confirmed_true do
      confirmed { true }
    end
  end
end
