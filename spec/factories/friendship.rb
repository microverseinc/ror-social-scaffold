FactoryBot.define do
  factory :confirmed_friendship, class: 'Friendship' do
    user_id {1}
    friend_id {2}
    confirmed {true}
  end

  factory :unconfirmed_friendship, class: 'Friendship' do
    user_id {1}
    friend_id {2}
    confirmed {false}
  end
end
