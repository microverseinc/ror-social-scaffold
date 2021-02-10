FactoryBot.define do
  factory :friendship do
    requester
    addressee
    status { 'accepted' }

    trait :pending do
      status { 'pending' }
    end
  end
end
