require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'friendship' do
    let(:user1) do
      User.create(name: 'Test1',
                  email: 'test1@email.com',
                  password: 'password',
                  password_confirmation: 'password')
    end

    let(:user2) do
      User.create(name: 'Test2',
                  email: 'test2@email.com',
                  password: 'password',
                  password_confirmation: 'password')
    end

    let(:friend_request) { Friendship.create(requester_id: user1.id, confirmer_id: user2.id) }

    it 'belongs_to user' do
      expect(friend_request).to eq(user2.friendships.first)
    end
  end

  describe 'associations' do
    it { should belong_to(:requester).class_name('User') }

    it { should belong_to(:confirmer) }
  end
end
