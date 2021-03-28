require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) do
    User.create(
      email: 'user@example.com',
      name: 'User',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  let(:post) do
    Post.new(content: 'This is a post', user_id: user.id)
  end

  let(:like) do
    Like.new(post_id: post.id, user_id: user.id)
  end

  describe 'associations' do
    it 'should belong to a user' do
      expect(like).to respond_to(:user)
    end

    it 'should belong to a post' do
      expect(like).to respond_to(:post)
    end
  end
end
