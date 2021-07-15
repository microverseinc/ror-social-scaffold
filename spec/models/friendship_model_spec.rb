require 'rails_helper'
# rubocop:disable Lint/UselessAssignment
RSpec.describe Friendship, type: :model do
  context 'User/friendship relations' do
    it 'Checks associations between User and Friendships' do
      user1 = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      user2 = User.create!(email: 'test2@email.com', name: 'testname2', password: 'testpassword2')
      friendship = Friendship.create!(user_id: user1.id, friend_id: user2.id, status: TRUE)
      inverse_friendship = Friendship.create!(user_id: user2.id, friend_id: user1.id, status: TRUE)
      expect(user1.friends).to eq([user2])
      expect(user2.friends).to eq([user1])
      expect(user1.friend?(user2)).to eq(TRUE)
      expect(user2.friend?(user1)).to eq(TRUE)
    end
  end

  context 'Friendship validation' do
    it 'Checks Friendship model validations' do
      user1 = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      user2 = User.create!(email: 'test2@email.com', name: 'testname2', password: 'testpassword2')
      friendship = Friendship.create!(user_id: user1.id, friend_id: user2.id, status: TRUE)
      expect(Friendship.all).to eq([friendship])
    end
  end
end
# rubocop:enable Lint/UselessAssignment
