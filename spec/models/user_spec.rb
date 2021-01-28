require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with all fields valid' do
      subject.email = 'example@mail.com'
      subject.name = 'example_name'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      expect(subject).to be_valid
    end

    it 'is not valid without a password' do
      subject.email = 'example@mail.com'
      subject.name = 'example_name'
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.name = 'example_name'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a name' do
      subject.email = 'example@mail.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password confirmation' do
      subject.email = 'example@mail.com'
      subject.name = 'example_name'
      subject.password = 'password'
      expect(subject).to_not be_valid
    end
  end

  context 'testing associations User' do
    it 'has many posts' do
      x = User.reflect_on_association(:posts)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many comments' do
      x = User.reflect_on_association(:comments)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many likes' do
      x = User.reflect_on_association(:likes)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many friendships' do
      x = User.reflect_on_association(:friendships)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many inverse_friendships' do
      x = User.reflect_on_association(:inverse_friendships)
      expect(x.macro).to eq(:has_many)
    end
  end

  context 'user methods' do
    let(:user) do
      User.create(name: 'Magz', email: 'magz@example.com', password: '123456',
                  password_confirmation: '123456')
    end

    let(:user1) do
      User.create(name: 'Jocy', email: 'jocy@example.com', password: '123456',
                  password_confirmation: '123456')
    end

    let(:user2) do
      User.create(name: 'Jocy1', email: 'jocy1@example.com', password: '123456',
                  password_confirmation: '123456')
    end

    it 'returns an array of users who are already friends' do
      user
      user1
      Friendship.create(user_id: user.id, friend_id: user1.id, confirmed: true)
      expect(user.friends).to include(user1)
    end

    it 'returns an array of users who have requested to be friends' do
      user1
      user2
      Friendship.create(user_id: user1.id, friend_id: user2.id)
      expect(user2.friend_requests).to include(user1)
    end

    it 'checks if user is a friend' do
      user
      user1
      Friendship.create(user_id: user.id, friend_id: user1.id, confirmed: true)
      expect(user.friend?(user1)).to eql(true)
    end
  end
end
