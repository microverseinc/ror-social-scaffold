require 'rails_helper'

describe 'Friendship', type: :feature do
  describe 'Create new friendship' do
    before :each do
      User.create(name: 'user_1', email: 'user_1@vv.com', password: '123456', password_confirmation: '123456')
      User.create(name: 'user_2', email: 'user_2@vv.com', password: '123456', password_confirmation: '123456')
    end
    it 'sends friend request' do
      user1 = User.find_by(name: 'user_1')
      user2 = User.find_by(name: 'user_2')
      check = user1.friendships.build(friend_id: user2.id, status: 'pending')
      check.save
      expect(check.persisted?).to be(true)
    end

    it 'accepts friend request' do
      user1 = User.find_by(name: 'user_1')
      user2 = User.find_by(name: 'user_2')
      check = user1.friendships.build(friend_id: user2.id, status: 'pending')
      check.save

      frie = Friendship.find_by(friend_id: user2.id)
      expect(frie.update(user_id: user1.id, friend_id: user2.id, status: 'approved')).to be(true)
    end
  end
end
