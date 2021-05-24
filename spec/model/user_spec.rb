require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'user', email: 'user@example.com', password: '987654321') }
  let(:inv_user) { User.create(name: '', email: 'user@example.com', password: '987654321') }
  let(:friendships) { User.reflect_on_association(:friendships).macro }
  let(:inverse_friendships) { User.reflect_on_association(:inverse_friendships).macro }
  let(:posts) { User.reflect_on_association(:posts).macro }
  let(:likes) { User.reflect_on_association(:likes).macro }
  let(:comments) { User.reflect_on_association(:comments).macro }
  let(:pending_friendships) { User.reflect_on_association(:pending_friendships).macro }
  let(:pending_friends) { User.reflect_on_association(:pending_friends).macro }
  let(:friends) { User.reflect_on_association(:friends).macro }
  let(:accepted_friends) { User.reflect_on_association(:accepted_friends).macro }
  let(:friendships_request) { User.reflect_on_association(:friendships_request).macro }

  it 'checks and validates user' do
    @user = User.create(name: 'user', email: 'user@example.com', password: '987654321')
    expect(@user).to be_valid
  end

  it 'checks if post association is has_many' do
    expect(posts).to eq(:has_many)
  end

  it 'checks if comment association is :has_many' do
    expect(comments).to eq(:has_many)
  end

  it 'checks if likes association is :has_many' do
    expect(likes).to eq(:has_many)
  end

  it 'check for the correct friendship association' do
    expect(friendships).to eq(:has_many)
  end

  it 'check if inverse_friendships association is correct' do
    expect(inverse_friendships).to eq(:has_many)
  end

  it 'check if pending_friendships association is correct' do
    expect(pending_friendships).to eq(:has_many)
  end

  it 'check if pending_friends association is correct' do
    expect(pending_friends).to eq(:has_many)
  end

  it 'check if friends association is correct' do
    expect(friends).to eq(:has_many)
  end

  it 'check if accepted_friends association is correct' do
    expect(accepted_friends).to eq(:has_many)
  end

  it 'check if friendships_request association is correct' do
    expect(friendships_request).to eq(:has_many)
  end

  context 'validation test' do
    it 'user name is present' do
      user = User.new(email: 'user@example.com', password: 'password').save
      expect(user).to eq(false)
    end

    it 'makes sure the minimum length of name is at least 3' do
      user = User.new(name: 'user', email: 'user@example.com', password: 'password').save
      expect(user).to eq(true)
    end

    it 'should save successfully' do
      user = User.new(name: 'User1', email: 'user@gmail.com', password: 'password').save
      expect(user) == true
    end
  end

  context 'helper methods test' do
    before(:each) do
      @user1 = User.create(name: 'User1', email: 'user1@example.com', password: 'password')
      @user2 = User.create(name: 'User2', email: 'user2@example.com', password: 'password')
    end

    it 'should return empty friends' do
      expect(@user1.friends.empty?).to eq(true)
    end

    it 'should return one incoming friend request' do
      @user1.friendships.new(friend_id: @user2.id, Acceptance: false).save
      expect(@user2.friend_requests.length).to eq(1)
    end

    it 'should return one pending friend request' do
      @user1.friendships.new(friend_id: @user2.id, Acceptance: false).save
      expect(@user1.pending_friends.length).to eq(1)
    end
  end
end
