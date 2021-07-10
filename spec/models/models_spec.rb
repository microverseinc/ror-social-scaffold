require 'rails_helper'

RSpec.describe User, type: :model do
  context 'User/friendship relations' do
    it 'Checks associations between User and Friendships' do
      user1 = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      user2 = User.create!(email: 'test2@email.com', name: 'testname2', password: 'testpassword2')
      friendship = Friendship.create!(user_id: user1.id, friend_id: user2.id, status: TRUE)
      expect(user1.friends).to eq([user2])
      expect(user2.friends).to eq([user1])
      expect(user1.friend?(user2)).to eq(TRUE)
      expect(user2.friend?(user1)).to eq(TRUE)
    end
  end

  context 'Posts/Comments relations' do
    it 'Checks associations between Posts and Comments' do
      user = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      post = Post.create!(content: 'post test', user_id: user.id)
      comment = Comment.create!(content: 'first comment', user_id: user.id, post_id: post.id)
      expect(post.comments).to eq([comment])
    end
  end

  context 'User/Posts relations' do
    it 'Checks associations between User and Posts' do
      user = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      post = Post.create!(content: 'post test', user_id: user.id)
      comment = Comment.create!(content: 'first comment', user_id: user.id, post_id: post.id)
      expect(user.posts).to eq([post])
    end
  end

  context 'User validation' do
    it 'Checks User model validations' do
      user = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      expect(User.all).to eq([user])
    end
  end

  context 'Post validation' do
    it 'Checks Post model validations' do
      user = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      post = Post.create!(content: 'post test', user_id: user.id)
      expect(Post.all).to eq([post])
    end
  end

  context 'Comment validation' do
    it 'Checks Comment model validations' do
      user = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      post = Post.create!(content: 'post test', user_id: user.id)
      comment = Comment.create!(content: 'first comment', user_id: user.id, post_id: post.id)
      expect(Comment.all).to eq([comment])
    end
  end

  context 'Friendship validation' do
    it 'Checks Friendship model validations' do
      user1 = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      user2 = User.create!(email: 'test2@email.com', name: 'testname2', password: 'testpassword2')
      friendship = Friendship.create!(user_id: user1.id, friend_id: user2.id, status: TRUE)
      expect(Friendship.all).to eq([friendship])
    end
  end
end
