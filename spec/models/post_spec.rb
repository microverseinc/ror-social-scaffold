require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.create(
      email: 'user@example.com',
      name: 'User',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  let(:user2) do
    User.create(
      email: 'User2@example.com',
      name: 'User2',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  let(:friendship) do
    Friendship.create(
      user_id: user.id,
      friend_id: user2.id,
      status: 1
    )
  end

  let(:post) do
    Post.new(content: 'This is a post', user_id: user.id)
  end

  describe 'validations' do
    it 'should not be valid without a content' do
      post.content = nil

      expect(post).to_not be_valid
    end

    it 'should have a content less than 1000 characters' do
      post2 = Post.create(content: 'a' * 1001, user_id: user.id)

      expect(post).to be_valid
      expect(post2).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should belong to a user' do
      expect(post).to respond_to(:user)
    end

    it 'can have many comments' do
      expect(post).to respond_to(:comments)
    end

    it 'can have many likes' do
      expect(post).to respond_to(:likes)
    end
  end
end
