FactoryBot.define do
  factory :friendship do
    requester
    receiver
    status { 'accepted' }

    trait :pending do
      status { 'pending' }
    end
  end
end
