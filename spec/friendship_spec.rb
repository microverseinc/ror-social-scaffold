require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validation' do
    it 'should not be valid without user_id' do
      expect(Friendship.create(user_id: nil, friend_id: 2, status: true)).to_not be_valid
    end
  end
end
