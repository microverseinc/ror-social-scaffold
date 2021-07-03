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
      friendship = Friendship.new(inviter_id: User.first.id, invitee_id: User.second.id, accepted: false)
      expect(friendship.valid?).to eq(true)
    end

    it 'rejects friendship if previously that request already exists' do
      Friendship.create(inviter_id: User.first.id, invitee_id: User.second.id, accepted: false)
      friendship = Friendship.new(inviter_id: User.second.id, invitee_id: User.first.id, accepted: false)
      expect(friendship.valid?).to eq(false)
    end

    it 'rejects friendship if the user invites themselves' do
      friendship = Friendship.new(inviter_id: User.first.id, invitee_id: User.first.id, accepted: false)
      friendship.valid?
      expect(friendship.errors.full_messages).to eq(["Inviter can't ask themselves for friendship"])
    end
  end

  describe 'update' do
    it 'updates a friendship to accept a friendship' do
      friendship = Friendship.create!(inviter_id: User.first.id, invitee_id: User.second.id, accepted: false)
      friendship.update(accepted: true)
      expect(friendship.accepted).to eq(true)
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
      Friendship.create(inviter_id: User.first.id, invitee_id: User.second.id, accepted: true)
      Friendship.create(inviter_id: User.third.id, invitee_id: User.first.id, accepted: true)
      Friendship.create(inviter_id: User.first.id, invitee_id: User.fourth.id, accepted: false)
      expect(User.first.friends.count).to eq(2)
    end
  end

  describe '#friends_unfiltered' do
    it 'shows all the friend requests of a user, whether they\'re accepted or not' do
      Friendship.create(inviter_id: User.first.id, invitee_id: User.second.id, accepted: true)
      Friendship.create(inviter_id: User.third.id, invitee_id: User.first.id, accepted: true)
      Friendship.create(inviter_id: User.first.id, invitee_id: User.fourth.id, accepted: false)
      expect(User.first.friends_unfiltered.count).to eq(3)
    end
  end

  describe '#pending_inviter_friends' do
    it 'shows all the pending friend requests proposed to the user' do
      Friendship.create(inviter_id: User.first.id, invitee_id: User.second.id, accepted: true)
      Friendship.create(inviter_id: User.third.id, invitee_id: User.first.id, accepted: false)
      Friendship.create(inviter_id: User.first.id, invitee_id: User.fourth.id, accepted: false)
      Friendship.create(inviter_id: User.fifth.id, invitee_id: User.first.id, accepted: true)
      expect(User.first.pending_inviter_friends.count).to eq(1)
    end
  end

  describe '#pending_invitee_friends' do
    it 'shows all the pending friend requests proposed to the user' do
      Friendship.create(inviter_id: User.first.id, invitee_id: User.second.id, accepted: true)
      Friendship.create(inviter_id: User.third.id, invitee_id: User.first.id, accepted: false)
      Friendship.create(inviter_id: User.first.id, invitee_id: User.fourth.id, accepted: false)
      Friendship.create(inviter_id: User.fifth.id, invitee_id: User.first.id, accepted: true)
      expect(User.first.pending_invitee_friends.count).to eq(1)
    end
  end
end
