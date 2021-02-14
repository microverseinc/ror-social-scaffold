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
    context 'when it is the first request' do
      it 'sends the request to the other user as pending status' do
        user = create(:user)
        another_user = create(:user)
        user.send_friend_request_to(another_user)

        expect(user.requests.map(&:id)).to match_array([another_user.id])
        expect(user.active_friendships.first.status).to eq('pending')
      end

      it 'raises an error if the user tries to send multiple requests' do
        user = create(:user)
        another_user = create(:user)
        user.send_friend_request_to(another_user)

        expect { user.send_friend_request_to(another_user) }.to raise_error(ActiveRecord::RecordNotUnique)
      end
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

  describe '#friend_lists' do
    it 'lists all the friends of the user' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)
      another_user.accept_friend_request_of(user)

      expect(user.friend_lists.map(&:id)).to match_array([another_user.id])
      expect(another_user.friend_lists.map(&:id)).to match_array([user.id])
    end

    it 'does not list the friends that have pending status' do
      user = create(:user)
      another_user = create(:user)
      another_user.send_friend_request_to(user)

      expect(user.friend_lists.count).to be_zero
    end
  end

  describe '#friend?' do
    it 'returns true if user is friend of another_user' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)
      another_user.accept_friend_request_of(user)

      expect(user.friend?(another_user)).to be_truthy
    end

    it 'returns false if user is not a friend of another user' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)

      expect(user.friend?(another_user)).to be_falsy
    end
  end

  describe '#mutual_friends_with' do
    it 'should list all the mutual friends with the user' do
      user = create(:user)
      another_user = create(:user)
      third_user = create(:user)
      create(:friendship, requester: another_user, addressee: third_user)
      create(:friendship, requester: user, addressee: third_user)
      create(:friendship, requester: user, addressee: another_user)

      expect(user.mutual_friends_with(third_user).map(&:id)).to match_array([another_user.id])
    end

    it 'does not have mutual friends' do
      user = create(:user)
      another_user = create(:user)
      third_user = create(:user)
      create(:friendship, requester: another_user, addressee: third_user)
      create(:friendship, requester: user, addressee: third_user)

      expect(user.mutual_friends_with(third_user)).to match_array([])
    end

    it 'should not list mutual friends if there arent any' do
      user = create(:user)
      another_user = create(:user)
      third_user = create(:user)
      create(:friendship, requester: another_user, addressee: third_user)

      expect(user.mutual_friends_with(third_user)).to match_array([])
    end
  end
end
