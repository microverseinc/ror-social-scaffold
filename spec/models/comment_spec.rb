require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.create(name: 'Marios', email: 'o@o.com',
                password: '000000', password_confirmation: '000000')
  end

  let(:post) { Post.create(content: 'This is a post', user_id: user.id) }

  let(:comment) { Comment.new(user_id: user.id, post_id: post.id, content: 'This is a comment') }

  describe 'validations' do
    it 'must have content' do
      expect(comment).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(comment).to respond_to(:user)
    end

    it 'belongs to a post' do
      expect(comment).to respond_to(:post)
    end
  end
end
