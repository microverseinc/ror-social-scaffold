FactoryBot.define do
  factory :friendship do
    confirmed { false }
    association :user, factory: :user
    friend { user }
  end
end
