require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(20) }
  end

  describe 'association' do
    it { should have_many(:posts) }

    it { should have_many(:comments).dependent(:destroy) }

    it { should have_many(:likes).dependent(:destroy) }

    it { should have_many(:friendships).with_foreign_key('requesting_user_id') }

    it { should have_many(:friendship_requests).with_foreign_key('receiving_user_id').class_name('Friendship') }
  end

  describe '#Friendships' do
    let(:sender) { create(:user) }

    let(:receiver) { create(:user) }

    let(:true_friendship) do
      Friendship.new(
        requesting_user: sender,
        receiving_user: receiver,
        request_status: true
      )
    end

    let(:false_friendship) do
      Friendship.new(
        requesting_user: sender,
        receiving_user: receiver,
        request_status: false
      )
    end

    it '#friends' do
      true_friendship.save
      expect(sender.friends).to include(receiver)
    end

    it '#friend?' do
      true_friendship.save
      expect(sender.friend?(receiver)).to be(true)
    end

    it '#pending_friends' do
      false_friendship.save
      expect(sender.pending_friends).to include(receiver)
    end

    it '#friend_request' do
      false_friendship.save
      expect(receiver.friend_requests).to include(sender)
    end

    it '#confirm_friend' do
      false_friendship.save
      receiver.confirm_friend(sender)
      expect(sender.friend?(receiver)).to be(true)
    end

    it '#reject_friend' do
      false_friendship.save
      receiver.reject_friend(sender)
      expect(sender.friend?(receiver)).to be(false)
    end

  end
end