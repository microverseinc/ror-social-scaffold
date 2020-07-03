require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) do
    User.new(
      name: 'Marios',
      email: 'o@o.com',
      password: '000000',
      password_confirmation: '000000'
    )
  end

  let(:post) do
    Post.new(content: 'This is a post', user_id: 1)
  end

  let(:like) do
    Like.new(post_id: 1, user_id: 1)
  end

  describe 'associations' do
    it 'belongs to post' do
      expect(like).to respond_to(:post)
    end

    it 'belongs to user' do
      expect(like).to respond_to(:user)
    end
  end
end
