require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { User.new(name: 'User1', email: 'user1@email.com', password: 'password') }

  it 'is a valid user' do
    expect(user1.valid?).to eq(true)
  end

  it 'has a valid username' do
    expect(user1.name).to eq('User1')
  end

  it 'has a maximum permitted length' do
    user1.name = 'i' * 21
    user1.valid?
    expect(user1.errors.full_messages).to include('Name is too long (maximum is 20 characters)')
  end

  it 'has a unique email' do
    _user2 = User.create(name: 'User2', email: 'user2@email.com', password: 'password')
    user3 = User.create(name: 'User3', email: 'user2@email.com', password: 'password')
    user3.valid?
    expect(user3.errors.full_messages).to include('Email has already been taken')
  end

  it 'can accept a friendship' do
    user2 = User.create(name: 'User2', email: 'user2@email.com', password: 'password')
    user3 = User.create(name: 'User3', email: 'user3@email.com', password: 'password')

    _friendship = Friendship.create(user_id: user2.id, friend_id: user3.id)

    user3.confirm_friend(user2)

    expect(user2.friend?(user3)).to be true
  end

  it 'has a secure password' do
    expect(user1.encrypted_password.nil?).to eq(false)
  end
end
