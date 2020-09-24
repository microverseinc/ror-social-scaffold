require 'rails_helper'

RSpec.describe 'Friendship' do
  context 'without friend_id' do
    it 'will not be valid ' do
      expect(Friendship.new(user_id: 1, status: 'pending').valid?).not_to be true
    end
  end
  context 'without user_id' do
    it 'will not be valid ' do
      expect(Friendship.new(friend_id: 1, status: 'pending').valid?).not_to be true
    end
  end
  context 'without status' do
    it 'will not be valid ' do
      expect(Friendship.new(user_id: 1, friend_id: 2).valid?).to be false
    end
  end
end
