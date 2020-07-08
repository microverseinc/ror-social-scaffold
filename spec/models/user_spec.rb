require 'rails_helper'

RSpec.describe 'User' do

  context 'user doesn\'t exist' do
    # let(:user_params) { { name: 'Tester', email: 'test@testing.com', password: '123456'} }
    let(:long_name) { 'a' * 25 }

    it 'can create a new user' do
      create(:random_user)
      expect(User.last).to be_present
    end

    it 'can\'t create a new user due to not having a password' do
      user = build(:random_user)
      user.password = nil
      expect(user.valid?).to_not eql(true)
    end

    it 'can\'t create a new user due to short password' do
      user = build(:random_user)
      user.password = '123'
      expect(user.valid?).to_not eql(true)
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

      it 'can check if friend is include in friends' do
        create(:confirmed_friendship)
        test = user.friends.include? friend
        expect(test).to eql(true)
      end

      it 'return false if friend is not confirmed like friend' do
        create(:unconfirmed_friendship)
        test = user.friends.include? friend
        expect(test).to_not eql(true)
      end

      it 'return true if friend is not confirmed like friend' do
        create(:unconfirmed_friendship)
        test = user.pending_friends.include? friend
        expect(test).to eql(true)
      end

      it 'not return true if friend is confirmed like friend' do
        create(:confirmed_friendship)
        test = user.pending_friends.include? friend
        expect(test).to_not eql(true)
      end

      it 'return not true if already friend is confirmed like friend' do
        create(:confirmed_request)
        test = user.friend_requests.include? friend
        expect(test).to_not eql(true)
      end

      it 'return true if friend is not confirmed like friend' do
        create(:unconfirmed_request)
        test = user.friend_requests.include? friend
        byebug
        expect(test).to eql(true)
      end

   end

      # expect(user.pending_friends).to eql([:friend])



     # it 'can check friend requests' do
    #   expect
    # end
    #
    # it 'can check friends' do
    #   expect
    # end
    #
    # it 'can check if a user is a friend' do
    #   expect
    # end
    #
    # it 'can confirm friends' do
    #   expect
    # end  end
end
