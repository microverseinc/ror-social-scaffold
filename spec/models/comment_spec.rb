require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.create(
      email: 'user@example.com',
      name: 'User',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  let(:post) do
    Post.create(content: 'This is a post', user_id: user.id)
  end

  let(:comment) do
    Comment.create(post_id: post.id, user_id: user.id, content: 'My first comment')
  end

  describe 'validations' do
    it 'should have a content less than 200 chars' do
      comment1 = Comment.create(user_id: user.id, post_id: post.id, content: 'a' * 201)

      expect(comment).to be_valid
      expect(comment1).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should belong to a user' do
      expect(comment).to respond_to(:user)
    end

    it 'should belong to a post' do
      expect(comment).to respond_to(:post)
    end
  end
end
