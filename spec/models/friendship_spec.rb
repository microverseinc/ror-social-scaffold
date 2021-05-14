require 'rails_helper'

RSpec.describe 'Friendship', type: :model do
  let(:user1) { User.create(name: 'user1', email: 'user1@example.com', password: 'password') }
  let(:user2) { User.create(name: 'user2', email: 'user22@example.com', password: 'password') }
  let(:friendship) { Friendship.create(user_id: user1.id, friend_id: user2.id, confirmed: false) }
  let(:inv_friendship) { Friendship.create(user_id: '', friend_id: user1.id, confirmed: false) }
  let(:user) { Friendship.reflect_on_association(:user).macro }
  let(:friend) { Friendship.reflect_on_association(:friend).macro }

  it 'checks if the friendship it done succefully' do
    expect(friendship).to be_valid
  end

  it 'check for invaild friendship' do
    expect(inv_friendship).to_not be_valid
  end

  it 'checks if friendship belongs_to the user' do
    expect(user).to eq(:belongs_to)
  end

  it 'checks if friendship belongs_to the friend' do
    expect(friend).to eq(:belongs_to)
  end
end
