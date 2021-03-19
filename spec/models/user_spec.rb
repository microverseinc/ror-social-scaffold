require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:friendrequests).dependent(:destroy) }
    it { should have_many(:inverse_friendrequests).class_name('Friendrequest').with_foreign_key('friend_id') }
  end

  before(:all) do
    User.create(name: 'angela', email: 'angela13@gmail.com', password: '123456')
    User.create(name: 'sharon', email: 'sharon11@gmail.com', password: '123456')
    User.first.friendrequests.create(friend_id: User.second.id)
  end

  describe 'send_request(user) method' do
    it 'is expected to send friend request' do
      User.create(name: 'linda', email: 'sharon123@gmail.com', password: '123456')
      User.second.send_request(User.last)
      expect(Friendrequest.last.status).to be_eql false
    end
  end
  describe 'friends method' do
    it 'is expected to give list of user\'s friends' do
      User.second.accept_friend(User.first)
      expect(User.first.friends[0].name).to be_eql 'sharon'
      expect(User.second.friends[0].name).to be_eql 'angela'
    end
  end

  describe 'pending_friends method' do
    it 'is expected to give list of user\'s pending friendrequest ' do
      expect(User.second.pending_friends[0].friend_id).to be_eql 2
      expect(User.second.pending_friends[0].status).to be_eql false
    end
  end
  describe 'friend_requests method' do
    it 'is expected to give list of friendrequest sent by user' do
      expect(User.first.friend_requests[0].user_id).to be_eql 1
      expect(User.first.friend_requests[0].status).to be_eql false
    end
  end
  describe 'confirm_friend method' do
    it 'is expected to accept friend request' do
      User.second.accept_friend(User.first)
      expect(Friendrequest.first.status).to be_eql true
    end
  end

  describe 'reject_friend method' do
    it 'is expected to reject friend request' do
      User.second.reject_friend(User.first)
      expect(Friendrequest.all.size).to be_eql 0
    end
  end

  describe 'confirmed_request method' do
    it 'is expected to give list of friendrequest confirmed by user' do
      User.second.accept_friend(User.first)
      expect(User.second.confirmed_request[0].friend_id).to be_eql 2
    end
  end

  describe 'friend?(user)' do
    it 'return true if friendrequest request is accepted' do
      User.second.accept_friend(User.first)
      expect(User.first.friend?(User.second)).to be_eql true
    end

    it 'return false if friendrequest request is rejected' do
      User.second.reject_friend(User.first)
      expect(User.first.friend?(User.second)).to be_eql false
    end
  end
end
