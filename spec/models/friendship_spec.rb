require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) do
    User.create(name: 'Thing 1',
                email: 'thing1@email.com',
                password: 'password',
                password_confirmation: 'password')
  end

  let(:user2) do
    User.create(name: 'Thing 2',
                email: 'thing2@email.com',
                password: 'password',
                password_confirmation: 'password')
  end
  let(:friendship1) { Friendship.create(user_id: user1.id, friend_id: user2.id, confirmed: false) }

  context 'validations' do
    it 'creates friendship when user accepts invitation' do
      f = Friendship.new(user_id: user1.id, friend_id: user2.id, confirmed: true)
      expect(f).to be_valid
    end

    it 'doesn\'t create frienshitp when user does not accept invitation' do
      Friendship.create(user_id: user1.id, friend_id: user2.id)
      f = Friendship.find_by(friend_id: user2.id)
      f.destroy
      expect(user1.friendships.include?(user2)).to eql(false)
    end

    it 'allows the creation of an inverse relationship' do
      friendship1
      friendship1.accepted
      f = Friendship.new(user_id: user2.id, friend_id: user1.id, confirmed: true)
      expect(f).to be_valid
    end
  end

  context 'testing associations' do
    it 'belongs to a user' do
      x = Friendship.reflect_on_association(:user)
      expect(x.macro).to eq(:belongs_to)
    end

    it 'belongs to a friend (another user)' do
      x = Friendship.reflect_on_association(:friend)
      expect(x.macro).to eq(:belongs_to)
    end
  end
end
