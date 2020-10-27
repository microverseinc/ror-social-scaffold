require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @user = User.create!(name: 'Diego Lira', email: 'diego@lira.com', password: '123123')
    @friend = User.create!(name: 'Laura Lira', email: 'laura@saldanha.com', password: '123123')
    @friendship_request_user = Friendship.create!(user_id: @user.id, friend_id: @friend.id, status: false)
    @friendship_request_friend = Friendship.create!(user_id: @friend.id, friend_id: @user.id, status: nil)
  end

  context 'check for friendship actions' do
    it 'should create a friendship for user' do
      expect(@friendship_request_user).to eql(Friendship.first)
    end

    it 'should create a friendship for friend' do
      expect(@friendship_request_friend).to eql(Friendship.second)
    end

    it 'should fail when creating a friendship request to a friend that does not exists' do
      expect(Friendship.create(user_id: @user.id, friend_id: 1_000_000, status: false)).not_to be_valid
    end

    it 'should accept a friendship request' do
      Friendship.accept_friendship(@friendship_request_user)
      expect(Friendship.check_friendship_status(@friend, @user)).to eq('Friends')
    end

    it 'should reject a friendship request' do
      Friendship.decline_friendship(@friendship_request_user)
      expect(Friendship.check_friendship_status(@friend, @user)).to eq('No relation')
    end
  end
end
