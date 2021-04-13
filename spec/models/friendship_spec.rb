require 'rails_helper'

describe Friendship, type: :model do
  before do
    User.create(name: 'John Smith', email: 'john.smith@email.com', password: 'abc123', gravatar_url: '')
    User.create(name: 'Betty Blue', email: 'betty_blue@email.com', password: 'abc123', gravatar_url: '')
  end

  let(:inviter) { User.find_by_name('John Smith') }
  let(:invitee) { User.find_by_name('Betty Blue') }
  let(:incorrect_invitee_user) { User.find_by_name('Betty') }

  # Model Tests
  context 'with correct params' do
    before do
      @friendship = Friendship.create(inviter_id: inviter.id, invitee_id: invitee.id)
    end

    it 'creates a friendship' do
      expect(@friendship).to be_valid
    end

    it 'reads a friendship' do
      expect(Friendship.find_by(inviter_id: inviter.id)).to eq(@friendship)
    end
  end

  context 'with incorrect params' do
    before do
      allow(incorrect_invitee_user).to receive(:id).and_return('a')
      @friendship = Friendship.create(inviter_id: inviter.id, invitee_id: incorrect_invitee_user.id)
    end

    it 'cannot create a friendship' do
      expect(@friendship).not_to be_valid
    end

    it 'cannot read a friendship' do
      expect(Friendship.find_by(inviter_id: inviter.id)).not_to eq(@friendship)
    end
  end

  # Association Tests
  it { should belong_to(:inviter) }
  it { should belong_to(:invitee) }
end
