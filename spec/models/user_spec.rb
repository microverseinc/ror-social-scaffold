require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do 
    it 'must have a name' do
      user = User.new(email: 'testuser@gmail.com', password: 'password').save
      expect(user).to eq(false)
    end

    it 'the name length should be <= 20 characters' do
      name = 't'*21
      user0 = User.new(email: 'test@user0.com', name: name, password: 'password').save
      expect(user0).to eq(false)
    end


    it 'must have an email' do
      user1 = User.new(name: 'user1', password: 'password').save
      expect(user1).to eq(false)
    end

    it 'must have a password' do
      user1 = User.new(name: 'user1', email: 'test@user1.com').save
      expect(user1).to eq(false)
    end

    it 'should create a user' do
      user2 = User.new(name: 'user2', email: 'test@user1.com', password: 'password').save
      expect(user2).to eq(true)
    end
  end

  context "friendships test" do
    before(:each) do
      @user1 = User.create(name: 'User One', email: 'userone@user.com', password: 'password')
      @user2 = User.create(name: 'User Two', email: 'usertwo@user.com', password: 'password')
    end

    it 'should not be friends to this user' do
      expect(@user1.friends.empty?).to eq(true)
    end

    it 'should be a friend request' do
      @user1.friendships.new(friend_id: @user2.id, confirmed: false).save
      expect(@user2.friend_requests.size).to eq(1)
    end

    it 'should be a pending request' do
      @user1.friendships.new(friend_id: @user2.id, confirmed: false).save
      expect(@user1.pending_friends.size).to eq(1)
    end

    it 'should be friends' do
      @user1.friendships.new(friend_id: @user2.id, confirmed: false).save
      @user2.friendships.new(friend_id: @user1.id, confirmed: false).save
      @user2.confirm_friend(@user1)
      @user1.confirm_friend(@user2)
      expect(@user1.friend?(@user2)).to eq(true)
      expect(@user2.friend?(@user1)).to eq(true)
    end
  end
end
