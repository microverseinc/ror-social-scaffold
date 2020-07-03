require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user1) do
    User.create(name: 'Marios', email: 'b@b.com',
                password: '000000', password_confirmation: '000000')
  end
  let(:user2) do
    User.create(name: 'Kubilay', email: 'a@b.com',
                password: '000000', password_confirmation: '000000')
  end

  let(:friendship) do
    Friendship.create(
      user_id: user1.id,
      friend_id: user2.id,
      status: true
    )
  end

  let(:post) do
    Post.new(content: 'This is a post', user_id: user1.id)
  end

  describe 'validations' do
    it 'must have content' do
      expect(post).to be_valid
    end
  end

  describe 'associations' do
    it 'has many comments' do
      expect(post).to respond_to(:comments)
    end

    it 'has many likes' do
      expect(post).to respond_to(:likes)
    end
  end
end
