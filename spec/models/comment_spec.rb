require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Comment model' do
    let(:user) { User.new(name: 'test', email: 'test@email.com', password: 'testing') }
    let(:post) { Post.new(content: 'Hello World!') }
    let(:comment) { Comment.new(content: 'This is a test!') }

    it 'VALID if not empty' do
      user.save
      post.save
      comment.user = user
      comment.post = post
      expect(comment).to be_valid
    end

    it 'INVALID if empty' do
      user.save
      post.save
      comment.user = user
      comment.post = post
      comment.content = ''
      expect(comment).not_to be_valid
    end

    it 'INVALID without POST' do
      user.save
      post.save
      comment.user = user
      comment.post = nil
      expect(comment).not_to be_valid
    end

    it 'INVALID without USER' do
      user.save
      post.save
      comment.user = nil
      comment.post = post
      expect(comment).not_to be_valid
    end

    context 'Associations for comment model' do
      it { should belong_to(:post) }
      it { should belong_to(:user) }
    end
  end
end
