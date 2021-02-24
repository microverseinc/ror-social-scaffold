require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:posts) }

    it { is_expected.to have_many(:likes) }

    it { is_expected.to have_many(:comments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_length_of(:name).is_at_most(20) }
  end

  describe 'send_friend_request_to' do
    context 'only send one time' do
      it 'send friend request to other user with pending status' do
        user = create(:user)
        another_user = create(:user)

        user.send_friend_request_to(another_user)

        expect(user.requesters.map(&:id)).to match_array([another_user.id])
        expect(user.active_friendships.first.status).to eq('pending')
      end
    end

    it 'raise error if user send multiple requests' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)

      expect { user.send_friend_request_to(another_user) }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe 'accept_friend_request' do
    it 'accepts other users friend requests' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)
      another_user.accept_friend_request(user)

      expect(another_user.passive_friendships.first.status).to eq('accepted')
      expect(user.active_friendships.first.status).to eq('accepted')
    end
  end

  describe 'delete_friend_request' do
    it 'delete other users friend requests' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)
      another_user.delete_friend_request(user)

      expect(another_user.receivers.map(&:id)).to match_array([])
      expect(user.requesters.map(&:id)).to match_array([])
    end
  end

  describe 'friends' do
    it 'list all friends of user' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)
      another_user.accept_friend_request(user)

      expect(user.friends.map(&:id)).to match_array([another_user.id])
      expect(another_user.friends.map(&:id)).to match_array([user.id])
    end

    it 'does not list friends that have pending status' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)

      expect(user.friends.count).to be_zero
    end
  end

  describe 'friend?' do
    it 'returns true if the user is friend of another user' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)
      another_user.accept_friend_request(user)

      expect(user.friend?(another_user)).to be_truthy
    end

    it 'returns false if the user is not friend of another user' do
      user = create(:user)
      another_user = create(:user)

      user.send_friend_request_to(another_user)

      expect(user.friend?(another_user)).to be_falsy
    end
  end

  describe 'mutual friends' do
    it 'should list all mutual friends' do
      user = create(:user)
      another_user = create(:user)
      other_user = create(:user)

      create(:friendship, requester: user, receiver: another_user)
      create(:friendship, requester: other_user, receiver: user)
      create(:friendship, requester: other_user, receiver: another_user)

      expect(other_user.mutual_friends(user).map(&:id)).to match_array([another_user.id])
    end
    it 'does not have mutual friends' do
      user = create(:user)
      another_user = create(:user)
      other_user = create(:user)

      create(:friendship, requester: user, receiver: another_user)
      create(:friendship, requester: other_user, receiver: user)

      expect(other_user.mutual_friends(user).map(&:id)).to match_array([])
    end
  end
end
