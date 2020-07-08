require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create :user }
  let(:friend) { create :user }
  let!(:friendship) do
    create(:friendship, user_id: user.id, friend_id: friend.id)
  end

  context '::reciprocate_friendship' do
    it 'appends user to friend friends' do
      expect(friend.friends).to include(user)
    end
  end

  context '::destroy_frienship' do
    it 'removes user to friend friends' do
      friendship.destroy
      expect(friend.friends).not_to include(user)
    end
  end
end
