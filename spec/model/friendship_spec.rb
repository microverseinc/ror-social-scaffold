require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { User.create(name: 'user', email: 'user@example.com', password: '987654321') }
  let(:pal) { User.create(name: '', email: 'user@example.com', password: '987654321') }
  let(:friendship) { Friendship.create(user_id: user.id, friend_id: pal.id, status: false) }
  let(:inv_friendship) { Friendship.create(user_id: '', friend_id: user.id, status: false) }
  let(:user) { Friendship.reflect_on_association(:user).macro }
  let(:friend) { Friendship.reflect_on_association(:friend).macro }

  it 'checks if friendship belongs_to the user' do
    expect(user).to eq(:belongs_to)
  end

  it 'checks if friendship belongs_to the friend' do
    expect(friend).to eq(:belongs_to)
  end
end
