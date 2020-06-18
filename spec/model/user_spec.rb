require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }
  let(:user1) { User.create(name: 'first', email: 'first@email.com', password: 'abc123') }
  let(:user2) { User.create(name: 'second', email: 'second@email.com', password: 'abc123') }
  let(:friend1) { user1.friendships.create(friend_id: 2) }
  let(:post1) { user1.posts.create(content: 'abc') }

  context 'Model' do
    it 'should exist' do
      expect(user).not_to be_nil
    end
  end

  context 'Autofill id using association' do
    it 'create a post' do
      user1.posts.create(content: 'abc')
      expect(user1.posts.first).not_to be_nil
    end
  end

  context 'Autofill id using association' do
    it 'create a comment' do
      post1.comments.create(user_id: 1, content: 'abc')
      expect(post1.comments).not_to be_nil
    end
  end

  context 'user can leave a like' do
    it 'leave a like' do
      user1.likes.create(post_id: 1)
      expect(post1.likes).not_to be_nil
    end
  end

  context 'Check for confirmed_friendships' do
    it 'association for user1 should return user2' do
      user1
      user2
      friend1
      friend1.acceptance = true
      friend1.save
      expect(user1.confirmed_friendships.first.friend).to eql(user2)
    end
  end

  context 'Check for pending_friendships' do
    it 'association for user1 should return user2' do
      user1
      user2
      friend1
      expect(user1.pending_friendships.first.friend).to eql(user2)
    end
  end

  context 'Check for inverted_friendships' do
    it 'association for user2 should return user1' do
      user1
      user2
      friend1
      expect(user2.inverted_friendships.first.user).to eql(user1)
    end
  end
end
