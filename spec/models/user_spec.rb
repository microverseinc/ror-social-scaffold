require 'rails_helper'

RSpec.describe 'User' do
  context 'user doesn\'t exist' do
    let(:long_name) { 'a' * 25 }

    it 'can create a new user' do
      create(:random_user)
      expect(User.last).to be_present
    end

    it 'can\'t create a new user due to not having a password' do
      user = build(:random_user)
      user.password = nil
      expect(user.valid?).to eql(false)
    end

    it 'can\'t create a new user due to not having a name' do
      user = build(:random_user)
      user.name = nil
      expect(user.valid?).to eql(false)
    end

    it 'can\'t create a new user due to short password' do
      user = build(:random_user)
      user.password = '123'
      expect(user.valid?).to eql(false)
    end

    it 'can\'t create a new user due to long name' do
      user = build(:random_user)
      user.name = 'a' * 25
      expect(user.valid?).to eql(false)
    end
  end

  context 'Model\'s user method' do
    let!(:user) { create(:random_user) }
    let!(:friend) { create(:random_friend) }

    it 'can check if friend is included in friends' do
      create(:confirmed_friendship)
      test = user.friends.include? friend
      expect(test).to eql(true)
    end

    it 'friend should be among pending friends' do
      create(:unconfirmed_friendship)
      expect(user.pending_friends).to include(friend)
    end

    it 'should be able to confirm friendship' do
      create(:unconfirmed_friendship)
      expect(user.confirm_friend(friend)).to eql(true)
    end

    it 'should be able to find friend among friend requests' do
      create(:unconfirmed_friendship)
      expect(friend.friend_requests).to include(user)
    end

    it 'return true if friend is among accepted friends' do
      create(:confirmed_friendship)
      expect(user.friend?(friend)).to eql(true)
    end
  end
end
