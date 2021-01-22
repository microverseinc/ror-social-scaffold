require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { User.create!(name: 'test', email: 'test@test.com', password: '123456', encrypted_password: '123456') }
  let(:user2) { User.create!(name: 'test2', email: 'test2@test.com', password: '123456', encrypted_password: '123456') }

  context 'Sending Request' do
    it 'should send friend request' do
      user1.sent_friend_requests.create(friend_id: user2.id)
      expect(Friendship.where('user_id = ? AND friend_id = ?', user1.id, user2.id).exists?).to eq(true)
    end

    it 'should have a default status of pending' do
      user1.sent_friend_requests.create(friend_id: user2.id)
      expect(user2.recieved_friend_requests.first.status).to eq('pending')
    end
  end

  context 'Instance Methods to Query Data' do
    describe '#friends' do
      it 'should return all the friend for user' do
        user1.sent_friend_requests.create(friend_id: user2.id)
        user2.recieved_friend_requests.first.update(status: :accepted)
        expect(user2.friends).to include(user1)
      end
    end

    describe '#pending_friend_requests' do
      it 'should return all the pending friends requests for a user' do
        request = user1.sent_friend_requests.create(friend_id: user2.id)
        expect(user2.pending_friend_requests.first).to eql(request)
      end
    end

    describe 'check_request_existence' do
      it 'should check if users are friends' do
        user1.sent_friend_requests.create(friend_id: user2.id)
        user2.recieved_friend_requests.first.update(status: :accepted)
        expect(user1.check_request_existence(user2)).to eql(true)
      end

      it 'should check if sent_friend_requests exists' do
        user1.sent_friend_requests.create(friend_id: user2.id)
        expect(user1.check_request_existence(user2)).to eql(true)
      end

      it 'should check if recieved_friend_requests exists' do
        user1.sent_friend_requests.create(friend_id: user2.id)
        expect(user2.check_request_existence(user1)).to eql(true)
      end
    end
  end
end
