require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { User.new(name: 'JohnDoe', email: 'johndoe@ymail.com', password: 'password') }
  let(:friend) { User.new(name: 'JaneDoe', email: 'janedoe@ymail.com', password: 'password') }
  let(:friendship) { Friendship.new(user_id:user.id , friend_id: friend.id,confirmed: true) }
  
  context 'It has friend_id, user_id and confirmed' do
    it 'has to have a friend_id' do
      expect(friendship.friend_id).to eq(friendship.friend_id)
    end
    it 'has to have a user_id' do
      expect(friendship.user_id).to eq(user.id)
    end
    it 'has to have a confirmed' do
      expect(friendship.confirmed).to eq(true)
    end
  end

  context 'it has to return an error for missing fields' do
    it 'returns an error for missing friend_id' do
      friendship.friend_id = nil
      expect(friendship.save).to eq(false)
    end
    it 'returns an error for missing user_id' do
      friendship.user_id = nil
      expect(friendship.save).to eq(false)
    end
    
  end
end
