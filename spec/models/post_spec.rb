require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'Doe', email: 'doe@mail.com', password: 'password') }
  let(:post) { Post.create(content: 'Hello!', user: user) }
  let(:post1) { Post.create(content: '') }

  context 'checks post' do
    it 'creates a valid post' do
      expect(post.valid?).to be true
    end

    it 'makes sure content is not empty' do
      post.content = ''
      expect(post).not_to be_valid
    end

    it 'makes sure the event has a user' do
      expect(post1).not_to be_valid
    end

    it 'test if we can add a comment' do
      comment = post.comments.create(user: user, content: 'This is funny')
      expect(comment.valid?).to be true
    end

    it 'test if we can like a post' do
      like = post.likes.create(user: user)
      expect(like.valid?).to be true
    end
  end
end
