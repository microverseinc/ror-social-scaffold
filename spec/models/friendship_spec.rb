require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  describe 'scopes' do
    let(:user1) { User.create(name: 'Marshall', email: 'uimarshall@gmail.com', password: 'pass123') }
    let(:user2) { User.create(name: 'Marshall2', email: 'uimarshall2@gmail.com', password: 'pass123') }

    it 'return false when there is not friendship' do
      expect(Friendship.find_friendship(user1, user2).to_a).to eq([])
    end

    it 'It should check for existence friendship' do
      friendship = Friendship.create!(user_id: user1.id, friend_id: user2.id)
      expect(Friendship.first).to eq(friendship)
      #  expect(Friendship.all.size).not_to eq(1)
    end
  end
end
