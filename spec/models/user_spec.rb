require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#friends' do
    subject(:user1) {
      described_class.new(name: "Chicken")
    }

    subject(:user2) {
      described_class.new(name: "Wai")
    }

    it 'should have a mutual friendship' do
      expect(user1).to receive(:friendships){ [Friendship.new(friend_id: 1, user_id: 2, status: true)] }
      expect(user1).to receive(:inverse_friendships){ [Friendship.new(friend_id: 1, user_id: 2, status: true)] }
      expect(user1.friends).to eq([1, 1])
      # print user1.friends
      # byebug
    end
  end
end
