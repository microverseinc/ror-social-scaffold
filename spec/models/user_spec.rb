require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:posts) }

    it { is_expected.to have_many(:comments) }

    it { is_expected.to have_many(:likes) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_length_of(:name).is_at_most(20) }
  end

  describe '#send_friend_request_to' do
    it 'sends the request to the other user as pending status' do
      user = create(:user)
      another_user = create(:user)
      user.send_friend_request_to(another_user)

      expect(user.requests.map(&:id)).to match_array([another_user.id])
      expect(user.active_friendships.first.status).to eq('pending')
    end
  end

  describe '#addressees' do
    it 'returns all the requests that user is sent to' do
      user = create(:user)
      john = create(:user, name: 'John')
      another_user = create(:user)

      user.send_friend_request_to(another_user)
      john.send_friend_request_to(another_user)

      expect(another_user.addressees.map(&:id)).to match_array([user.id, john.id])
    end
  end

  describe '#accept_friend_request_of' do
    it 'accepts the friend request of the requester' do
      user = create(:user)
      another_user = create(:user)
      user.send_friend_request_to(another_user)
      another_user.accept_friend_request_of(user)

      expect(another_user.passive_friendships.first.status).to eq('accepted')
      expect(user.active_friendships.first.status).to eq('accepted')
    end
  end

  describe '#delete_friend_request_of' do
    it 'deletes the friend request of the requester' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)
      another_user.delete_friend_request_of(user)

      expect(another_user.addressees.map(&:id)).to match_array([])
      expect(user.requests.map(&:id)).to match_array([])
    end
  end
end
