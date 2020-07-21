require 'rails_helper'

RSpec.describe 'Friendship' do
  context 'when pending friendship exists' do
    let!(:user) { create(:random_user) }
    let!(:friend) { create(:random_friend) }
    let!(:friendship) { create(:unconfirmed_friendship) }

    it 'should find the pending friendship using scope find_friendship' do
      expect(user.pending_friendships.find_friendship(friend)[0]).to eql(friendship)
    end

    it 'should find the inverse pending friendship using scope find_inverse_friendship' do
      expect(friend.inverse_friendships.find_inverse_friendship(user)[0]).to eql(friendship)
    end
  end
end
