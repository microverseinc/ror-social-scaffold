require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Test for invalid user' do
    before do
      @user = User.create(name: 'henry', email: 'verissimohemry04@gmail.com')
    end
    it 'returns false if not all params are filled in.' do
      expect(@user).to_not be_valid
    end

    it "Can't read a user that has not been created." do
      expect(User.find_by(name: 'henry')).to_not eq(@user)
    end
  end

  context 'Test for valid User' do
    before do
      @user = User.create(name: 'henry', email: 'verissimohemry04@gmail.com', password: '123456')
    end
    it 'returns true for creating user' do
      expect(@user).to be_valid
    end

    it 'Read a user that has been created.' do
      expect(User.find_by(name: 'henry')).to eq(@user)
    end
  end
  context 'Test for friends' do
    before do
      @user = User.create(name: 'henry', email: 'verissimohemry04@gmail.com', password: '123456')
      @friend = User.create(name: 'tobi', email: 'tobi@gmail.com', password: '123456')
      @invite = Friendship.create(user_id: @user.id, friend_id: @friend.id)
    end

    it 'return false if friend is not in friend list' do
      expect(@user.friend?(@friend)).to eq(false)
    end

    it 'Return one if friend did not accept request' do
      expect(@user.pending_friends.count).to eq(1)
    end

    it 'Return one if user did not accept request' do
      expect(@friend.friend_requests.count).to eq(1)
    end

    it 'Return zero if user accepted request' do
      @friend.confirm_friend(@user)
      expect(@friend.friend_requests.count).to eq(0)
    end
  end
  context 'Test for friends' do
    before do
      @user = User.create(name: 'henry', email: 'verissimohemry04@gmail.com', password: '123456')
      @friend = User.create(name: 'tobi', email: 'tobi@gmail.com', password: '123456')
      @invite = Friendship.create(user_id: @user.id, friend_id: @friend.id, confirmed: true)
    end
    it 'return true if friend is in friend list' do
      expect(@user.friend?(@friend)).to eq(true)
    end

    it 'Return zero if friend accepted request' do
      expect(@user.pending_friends.count).to eq(0)
    end

    it 'Return zero if user accepted request' do
      expect(@friend.friend_requests.count).to eq(0)
    end
  end
end
