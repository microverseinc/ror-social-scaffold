require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.create(
      name: 'Jay',
      email: 'jay@jay.com',
      password: '000000',
      password_confirmation: '000000'
    )
  end
  let(:user2) do
    User.create(
      name: 'Kay',
      email: 'kay@kay.com',
      password: '000000',
      password_confirmation: '000000'
    )
  end

  describe 'validations' do
    it 'must have a name shorter than 20 chars' do
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user.name = nil
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many posts' do
      expect(user).to respond_to(:posts)
    end

    it 'has many comments' do
      expect(user).to respond_to(:comments)
    end

    it 'has many likes' do
      expect(user).to respond_to(:likes)
    end

    it 'user1 sends friend_request' do
      user.send_friend_request(user, user2)
      friendship = user2.friend_requests
      expect(friendship.empty?).to be false
    end

    it 'shows user1 pending friends' do
      user.send_friend_request(user, user2)
      pending_friends = user.pending_friends
      expect(pending_friends.empty?).to be false
    end

    it 'user2 rejects friend_request' do
      user.send_friend_request(user, user2)
      user2.reject_friend_request(user)
      friendship = user2.friend_requests
      expect(friendship.empty?).to be true
    end

    it 'user2 accepts friend_request' do
      user.send_friend_request(user, user2)
      user2.confirm_friend(user)
      friendship = user2.friends
      expect(friendship.empty?).to be false
    end

    it 'returns true if two users are friends' do
      user.send_friend_request(user, user2)
      user2.confirm_friend(user)
      friendship = user2.friend?(user)
      expect(friendship).to be true
    end
  end
end
