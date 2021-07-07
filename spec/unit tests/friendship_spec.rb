require 'rails_helper'

RSpec.describe Friendship do
  before(:each) do
    User.create(name: 'Julian', email: 'julian@example.com',
                gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
                password: 'Secret1', password_confirmation: 'Secret1')
    User.create(name: 'Enio', email: 'enio@example.com',
                gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
                password: 'Secret1', password_confirmation: 'Secret1')
  end

  describe 'creation' do
    it 'validates friendship between two existing users' do
      Friendship.safe_create(User.first.id, User.second.id)
      expect(User.first.friends).to eq([User.second])
    end

    it 'rejects friendship if previously that request already exists' do
      Friendship.safe_create(User.first.id, User.second.id)
      friendship = Friendship.new(user_id: User.second.id, friend_id: User.first.id, status: false)
      expect(friendship.valid?).to eq(false)
    end

    it 'rejects friendship if the user invites themselves' do
      friendship = Friendship.new(user_id: User.first.id, friend_id: User.first.id, status: false)
      friendship.valid?
      expect(friendship.errors.full_messages).to eq(["User can't be friends to themselves"])
    end
  end

  describe 'update' do
    it 'updates a friendship to accept a friendship' do
      Friendship.safe_create(User.first.id, User.second.id)
      friendship = Friendship.find_by(user_id: User.second.id, friend_id: User.first.id)
      friendship.update(status: true)
      expect(friendship.status).to eq(true)
    end
  end
end

RSpec.describe User do
  before(:each) do
    User.create(name: 'Julian',
                email: 'julian@example.com',
                gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
                password: 'Secret1', password_confirmation: 'Secret1')

    User.create(name: 'Enio',
                email: 'enio@example.com',
                gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
                password: 'Secret1', password_confirmation: 'Secret1')

    User.create(name: 'User001',
                email: 'user001@example.com',
                gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
                password: 'Secret1', password_confirmation: 'Secret1')

    User.create(name: 'User002',
                email: 'user002@example.com',
                gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
                password: 'Secret1', password_confirmation: 'Secret1')

    User.create(name: 'User003',
                email: 'user003@example.com',
                gravatar_url: 'https://www.w3schools.com/howto/img_avatar.png',
                password: 'Secret1', password_confirmation: 'Secret1')
  end

  describe '#friends' do
    it 'shows all the accepted friends of a user' do
      Friendship.safe_create(User.first.id, User.second.id)
      Friendship.find_by(user_id: User.second.id, friend_id: User.first.id).update(status: true)
      Friendship.safe_create(User.third.id, User.first.id)
      Friendship.find_by(user_id: User.first.id, friend_id: User.third.id).update(status: true)
      Friendship.safe_create(User.fourth.id, User.first.id)
      expect(User.first.accepted_friends.count).to eq(2)
    end
  end

  describe '#friends_unfiltered' do
    it 'shows all the friend requests of a user, whether they\'re accepted or not' do
      Friendship.safe_create(User.first.id, User.second.id)
      Friendship.safe_create(User.third.id, User.first.id)
      Friendship.safe_create(User.first.id, User.fourth.id)
      expect(User.first.friends.count).to eq(3)
    end
  end

  describe '#pending_inviters' do
    it 'shows all the pending friend requests proposed to the user' do
      Friendship.safe_create(User.first.id, User.second.id)
      Friendship.find_by(user_id: User.second.id, friend_id: User.first.id).update(status: true)
      Friendship.safe_create(User.third.id, User.first.id)
      Friendship.find_by(user_id: User.first.id, friend_id: User.third.id).update(status: true)
      Friendship.safe_create(User.fourth.id, User.first.id)
      expect(User.first.pending_inviters.count).to eq(1)
    end
  end

  describe '#pending_invitees' do
    it 'shows all the pending friend requests proposed to the user' do
      Friendship.safe_create(User.first.id, User.second.id)
      Friendship.find_by(user_id: User.second.id, friend_id: User.first.id).update(status: true)
      Friendship.safe_create(User.third.id, User.first.id)
      Friendship.find_by(user_id: User.first.id, friend_id: User.third.id).update(status: true)
      Friendship.safe_create(User.fourth.id, User.first.id)
      expect(User.fourth.pending_invitees.count).to eq(1)
    end
  end
end
