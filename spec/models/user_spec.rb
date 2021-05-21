require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'is valid with valid attributes' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
  end

  describe 'is associated to posts, comments, likes, friendships(senders), and friendships(receivers)' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:senders) }
    it { should have_many(:receivers) }
  end

  describe 'can request friendship and accept/reject them' do
    let(:user1) { User.create(id: 1, name: 'user1', email: 'user1@gmail.com', password: '123456') }
    let(:user2) { User.create(id: 2, name: 'user2', email: 'user2@gmail.com', password: '123456') }

    it 'requests friendship' do
      user1.senders.create!(receiver_id: user2.id)
      expect(Friendship.where(sender_id: 1, receiver_id: 2)).not_to eq nil
    end

    it 'accepts friendship' do
      user1.senders.create!(receiver_id: user2.id)
      Friendship.where(sender_id: 1, receiver_id: 2).update(status: 1)
      expect(Friendship.where(sender_id: 1, receiver_id: 2).first.status).to eq(1)
    end

    it 'rejects friendship' do
      user1.senders.create!(receiver_id: user2.id)
      friendship = Friendship.where(sender_id: 1, receiver_id: 2).first
      friendship.destroy
      expect(Friendship.where(sender_id: 1, receiver_id: 2).first).to eq nil
    end

    # describe '#friends' do
    #   it 'returns friends of a given user' do
    #     user1.requests_for_friendship(user2)
    #     user2.approve_request(user1)
    #     expect(user1.friends).to include user2
    #   end

    #   it 'doesnt return users that are not friends' do
    #     user1.requests_for_friendship(user2)
    #     expect(user1.friends).not_to include user2
    #   end
    # end

    # describe '#friend?' do
    #   it 'returns true if a given user is a friend' do
    #     user1.requests_for_friendship(user2)
    #     user2.approve_request(user1)
    #     expect(user1.friend?(user2)).to eq true
    #   end

    #   it 'returns false if a given user is not a friend' do
    #     user1.requests_for_friendship(user2)
    #     expect(user1.friend?(user2)).to eq false
    #   end
    # end

    # describe '#pending_requests_i_sent' do
    #   it 'returns users that has not accepted my request yet' do
    #     user1.requests_for_friendship(user2)
    #     expect(user1.pending_requests_i_sent).to include user2
    #   end
    # end

    # describe '#pending_requests_i_got' do
    #   it 'returns users that I have not accepted their requests yet' do
    #     user2.requests_for_friendship(user1)
    #     expect(user1.pending_requests_i_got).to include user2
    #   end
    # end
  end
end
