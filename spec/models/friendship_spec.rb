require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:friend_id) }
    it { is_expected.to validate_presence_of(:requester_id) }
  end

  describe 'scopes' do
    let(:user1) { User.create(name: 'Marshall', email: 'uimarshall@gmail.com', password: 'pass123') }
    let(:user2) { User.create(name: 'Marshall2', email: 'uimarshall2@gmail.com', password: 'pass123') }
    let(:user3) { User.create(name: 'Marshall3', email: 'uimarshall3@gmail.com', password: 'pass123') }

    it 'return empty relation when there is not friendship' do
      expect(Friendship.find_friendship(user1, user2).to_a).to eq([])
    end

    it 'it can find friendships' do
      friendship = Friendship.create!(user_id: user1.id, friend_id: user2.id, requester_id: user1.id)

      expect(Friendship.find_friendship(user1, user2).first).to eq(friendship)
    end

    it 'it can find both rows of friendships after is created' do
      friendship = Friendship.create!(user_id: user1.id, friend_id: user2.id, requester_id: user1.id)
      friendship2 = Friendship.second

      expect(Friendship.find_both_friendships(user1, user2).to_a).to eq([friendship, friendship2])
    end

    it 'creates both rows in the database when creating a friendship' do
      friendship = Friendship.create!(user_id: user2.id, friend_id: user3.id, requester_id: user2.id)
      friendship2 = Friendship.second
      expect(Friendship.all.to_a).to eq([friendship, friendship2])
    end
  end
end
