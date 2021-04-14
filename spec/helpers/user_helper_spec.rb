require 'rails_helper'

RSpec.describe UserHelper, type: :helper do
  before do
    User.create(name: 'John Smith', email: 'john.smith@email.com', password: 'abc123', gravatar_url: '')
    User.create(name: 'Betty Blue', email: 'betty_blue@email.com', password: 'abc123', gravatar_url: '')
    User.create(name: 'Elvis Presley', email: 'elvis_presley@email.com', password: 'abc123', gravatar_url: '')
  end

  let(:inviter) { User.find_by_name('John Smith') }
  let(:invitee) { User.find_by_name('Betty Blue') }
  let(:inviter2) { User.find_by_name('Elvis Presley') }
  let(:incorrect_invitee_user) { User.find_by_name('Betty') }

  describe '#add_friend_button' do
    before do
      @friendship = Friendship.create(inviter_id: inviter.id, invitee_id: invitee.id)
    end

    it 'returns true if invitee_id equals inviter_id in the conditional statement' do
      expect(add_friend_button(inviter.id, inviter.id)).to eq(true)
    end

    it 'returns false if invitee_id is not equal to inviter_id' do
      expect(add_friend_button(inviter.id, invitee.id)).to eq(true)
    end

    it 'returns false if a user is not in a friendship with the current_user' do
      expect(add_friend_button(inviter_2.id, invitee.id)).to eq(false)
    end
  end
end
