FactoryBot.define do
  factory :friendship do
    user_id { 1 }
    friend_id { 2 }
    confirmed { false }
  end
end
