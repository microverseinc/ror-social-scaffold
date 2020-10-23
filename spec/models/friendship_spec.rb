require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @user = User.create!(name: 'Diego Lira', email: 'diego@lira.com', password: '123123')
    @friend = User.create!(name: 'Laura Lira', email: 'laura@saldanha.com', password: '123123')
    @friendship_request_true = Friendship.create!(user_id: @user.id, friend_id: @friend.id, status: false)
  end

  context 'check for friendship actions' do
    it 'should create a friendship request' do
      expect(@friendship_request_true).to eql(Friendship.first)
    end

    it 'should fail when creating a friendship request to a friend that does not exists' do
      expect(Friendship.create(user_id: @user.id, friend_id: 1_000_000, status: false)).not_to be_valid
    end

    it 'should accept a friendship request' do
      Friendship.accept_friendship(@friendship_request_true)
      expect(Friendship.check_friendship_status(@friend, @user)).to eq('Friends')
    end

    it 'should reject a friendship request' do
      Friendship.decline_friendship(@friendship_request_true)
      expect(Friendship.check_friendship_status(@friend, @user)).to eq('No relation')
    end
  end
end
