require 'rails_helper'

RSpec.feature 'Friendship' do
  let!(:user) { create(:random_user) }
  let!(:friend) { create(:random_friend) }

  context 'User creates' do
    it 'a friend request' do
      friend_request = create(:unconfirmed_friendship)
      expect(friend_request).to exist
    end

    it 'friend request is accepted' do
      friendship = create(:unconfirmed_friendship)
      friendship.update(confirmed: true)
      expect(friendship.confirmed).to eql(true)
    end

    it 'friend request is rejected' do
      friendship = create(:unconfirmed_friendship)
      friendship.destroy
      expect(friendship).to_not exist
    end

  end
end
