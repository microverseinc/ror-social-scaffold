require 'rails_helper'

RSpec.describe Friendship do
  fixtures :users
  fixtures :friendships

  subject(:one) { friendships(:one) }

  describe 'Validity from fixture with user_id,friend_id' do
    it 'should be valid' do
      friendship = Friendship.new(user_id: 1, friend_id: 2, confirmed: true)
      expect(friendship).to be_valid
    end
  end

  describe :invalid_name do
    it 'should have valid name' do
      friendship = Friendship.new(friend_id: 2, confirmed: true)
      friendship.valid?
      expect(friendship.errors.full_messages).to include('User must exist')
      expect(friendship).not_to be_valid
    end
  end

  describe :invalid_password do
    it 'should have valid friend id' do
      friendship = Friendship.new(user_id: 1, confirmed: true)
      friendship.valid?
      expect(friendship.errors.full_messages).to include('Friend must exist')
      expect(friendship).not_to be_valid
    end
  end
end
