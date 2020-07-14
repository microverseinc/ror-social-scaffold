require 'rails_helper'

RSpec.describe User, type: :model do
  let(:requester) { create :user }
  let(:receiver) { create :user }
  let!(:friendship) { create :friendship, requester: requester, receiver: receiver }

  context 'Requested and received friendships' do
    it 'Requester should be in received_friends' do
      expect(receiver.received_friends).to include(requester)
    end

    it 'Receiver should be in requested_friends' do
      expect(requester.requested_friends).to include(receiver)
    end
  end

  context 'Confirmed friendships' do
    let!(:friendship) { create :friendship, requester: requester, receiver: receiver, confirmed: true }
    it 'Receiver should be in friends' do
      expect(requester.friends).to include(receiver)
    end

    it 'Requester should be in friends' do
      expect(receiver.friends).to include(requester)
    end
  end
end
