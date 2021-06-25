require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }

    it 'returns true if two given users are friends' do
      user1 = User.create(email: 'user1@email.com', password: 'secret123', name: 'User1')
      user2 = User.create(email: 'user2@email.com', password: 'secret123', name: 'User2')
      request = Friendship.create(user_id: user1.id, friend_id: user2.id, status: true)
      expect(request.status).to be true
    end

    it 'returns false if there is a pending invitation' do
      user1 = User.create(email: 'user1@email.com', password: 'secret123', name: 'User1')
      user2 = User.create(email: 'user2@email.com', password: 'secret123', name: 'User2')
      request = user1.friendships.create(friend_id: user2.id)
      expect(request.status).to be_falsey
    end

    it 'returns false if two given users are not friends' do
      user1 = User.create(email: 'user1@email.com', password: 'secret123', name: 'User1')
      user2 = User.create(email: 'user2@email.com', password: 'secret123', name: 'User2')
      request = Friendship.create(user_id: user1.id, friend_id: user2.id, status: false)
      expect(request.status).to be false
    end
  end
end
