require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let!(:user1) { User.create(name: 'test1', email: 'test1@email.com', password: '123456') }
  let!(:user2) { User.create(name: 'test2', email: 'test2@email.com', password: '123456') }
  describe 'create friendship' do
    it 'builds friendships relation correctly' do
      user1.friendships.create(friend_id: user2.id)
      expect(user1.friendships.find_by(friend_id: user2.id)).to eql(user2.friend_requests.find_by(user_id: user1.id))
    end
    it 'builds friendships with status false as default' do
      user1.friendships.create(friend_id: user2.id)
      expect(user1.friendships.find_by(friend_id: user2.id).status).to eql(false)
    end
    it 'creates a symetrical record when the friend request is accepted' do
      user1.friendships.create(friend_id: user2.id)
      expect(user2.friendships.find_by(friend_id: user1.id)).to eql(nil)
      u = user1.friendships.find_by(friend_id: user2.id)
      u.status = true
      u.save
      expect(user2.friendships.find_by(friend_id: user1.id).user_id).to eql(
        user1.friendships.find_by(friend_id: user2.id).friend_id
      )
      expect(user2.friendships.find_by(friend_id: user1.id).friend_id).to eql(
        user1.friendships.find_by(friend_id: user2.id).user_id
      )
    end
  end
end
