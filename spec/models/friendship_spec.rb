require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { User.create(name: 'user_tes1', email: 'mail1@mail.com', password: 'password') }
  let(:user2) { User.create(name: 'user_test2', email: 'mail2@mail.com', password: 'password') }
  let(:user3) { User.create(name: 'user_test3', email: 'mail2@mail.com', password: 'password') }

  describe 'An User can ' do
    it 'Send envitation' do
      friendship = user1.friendships.new(friend_id: user2.id)
      friendship.save
      expect(user1.pending_friends.size).to eq(1)
    end
    it 'Accept invitation' do
      friendship = user1.friendships.new(friend_id: user2.id)
      friendship.save
      user2.confirm_friend(user1)
      friends = user1.friend?(user2)
      expect(friends).to eq(true)
    end
    it 'reject invitation' do
      friendship = user1.friendships.new(friend_id: user2.id)
      friendship.save
      user2.reject_friend(user1)
      friends = user1.friend?(user2)

      expect(friends).to eq(false)
      expect(user1.inverse_friendships.size).to eq(0)
    end
    it 'can be friend' do
      friendship = user1.friendships.new(friend_id: user2.id)
      friendship.save
      expect(user1.pending_friends.size).to eq(1)
    end
    it 'Accept invitation and both are friends' do
      friendship = user1.friendships.new(friend_id: user2.id)
      friendship.save
      user2.confirm_friend(user1)
      friends = user2.friend?(user1)
      expect(friends).to eq(true)
    end
  end
end
