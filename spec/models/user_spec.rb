require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'is valid with valid attributes' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
  end

  describe 'is associated to posts, comments, likes, friendships(inviters), and friendships(invitees)' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'can request friendship and accept/reject them' do
    let(:user1) { User.create(id: 1, name: 'user1', email: 'user1@gmail.com', password: '123456') }
    let(:user2) { User.create(id: 2, name: 'user2', email: 'user2@gmail.com', password: '123456') }

    it 'requests friendship' do
      user1.friendship_request(user2)
      expect(Friendship.where(inviter_id: 1, invitee_id: 2)).not_to eq nil
    end

    it 'accepts friendship' do
      user1.friendship_request(user2)
      user2.accept_request(user1)
      expect(Friendship.where(inviter_id: 1, invitee_id: 2).first.accepted).to eq(true)
    end

    it 'rejects friendship' do
      user1.friendship_request(user2)
      user2.reject_request(user1)
      expect(Friendship.where(inviter_id: 1, invitee_id: 2).first).to eq nil
    end
  end
end
