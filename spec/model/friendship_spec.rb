require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'friendship' do
    let(:user1) do
      User.create(name: 'Example User',
                  email: 'example@email.com',
                  password: 'foobar',
                  password_confirmation: 'foobar')
    end
    let(:user2) do
      User.create(name: 'Other User',
                  email: 'other@email.com',
                  password: 'foobar',
                  password_confirmation: 'foobar')
    end

    let(:friend_request) { Friendship.create(user_id: user1.id, friend_id: user2.id) }

    it 'belongs_to user' do
      expect(friend_request).to eq(user1.friendships.first)
    end
  end

  describe 'associations' do
    it { should belong_to(:friend).class_name('User') }

    it { should belong_to(:user) }
  end
end
