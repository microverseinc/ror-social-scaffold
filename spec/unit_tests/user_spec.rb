require 'spec_helper'
require 'rails_helper'

RSpec.describe 'User model tests', type: :model do
  let(:test_user) do
    User.new(name: 'test_user', email: 'test@user.com',
             password: 'secret', password_confirmation: 'secret')
  end
  let(:test_user_2) do
    User.new(name: 'test_user_2', email: 'test2@user.com',
             password: 'secret', password_confirmation: 'secret')
  end
  let(:test_user_3) do
    User.new(name: 'test_user_3', email: 'test3@user.com',
             password: 'secret', password_confirmation: 'secret')
  end
  let(:test_friendship) do
    Friendship.new(user_id: test_user.id, friend_id: test_user_2.id, confirmed: true)
  end
  let(:test_friendship_2) do
    Friendship.new(user_id: test_user_3.id, friend_id: test_user.id, confirmed: true)
  end

  def store_in_database
    test_user.save
    test_user_2.save
    test_user_3.save
    test_friendship.save
    test_friendship_2.save
  end

  describe 'instance methods' do
    it 'returns the correct list of friends' do
      store_in_database
      user = User.first
      user_friends = user.friends
      expect(user_friends.include?(User.second) && user_friends.include?(User.third)).to eq(true)
    end

    it 'returns the sent invitations' do
      store_in_database
      test_friendship.update(confirmed: false)

      expect(test_user.friends_requests_sent).to include(test_user_2)
    end

    it 'returns the received invitations' do
      store_in_database
      test_friendship_2.update(confirmed: false)

      expect(test_user.friends_requests_received).to include(test_user_3)
    end

    it 'confirms accurately if a user is a friend' do
      store_in_database
      expect(test_user.friend?(test_user_3)).to eq(true)
    end

    it 'confirms accurately if a user is not a friend' do
      store_in_database
      test_friendship_2.update(confirmed: false)
      expect(test_user.friend?(test_user_3)).to eq(false)
    end

    it 'confirms if a friend request has been sent to a specific user' do
      store_in_database
      test_friendship.update(confirmed: false)
      expect(test_user.friend_request_sent?(test_user_2)).to eq(true)
    end

    it 'confirms if a friend request has not been sent to a specific user' do
      store_in_database
      expect(test_user.friend_request_sent?(test_user_3)).to eq(false)
    end

    it 'confirms if a friend request has been received from a specific user' do
      store_in_database
      test_friendship_2.update(confirmed: false)
      expect(test_user.friend_request_received?(test_user_3)).to eq(true)
    end

    it 'confirms if a friend request has not been received from a specific user' do
      store_in_database
      expect(test_user.friend_request_received?(test_user_2)).to eq(false)
    end
  end
end
