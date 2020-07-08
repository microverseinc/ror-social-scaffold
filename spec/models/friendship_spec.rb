require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe '#reciprocate_friendship' do
    let(:user) { create :user }
    let(:friend) { create :user }
    let(:friendship) { build :friendship, user_id: user.id, friend_id: friend.id }

    it "appends user to friend friends" do
      expect(friend.friends).to include(user)
    end
  end
end

