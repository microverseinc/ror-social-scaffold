require 'rails_helper'

RSpec.describe 'Like Model', type: :model do
  describe 'validations' do
    let(:user) do
      User.new(
        name: 'john',
        email: 'john@gmail.com',
        password: 'password'
      )
    end
    let(:post) do
      Post.new(
        content: 'This is a new post',
        user_id: user.id
      )
    end

    before(:each) do
      user.save
      post.save
    end

    it 'is belongs to a user' do
      like = Like.new(user_id: user.id, post_id: post.id)
      like.save
      expect(like.user.id).to eq(user.id)
    end

    it 'is belongs to a post' do
      like = Like.new(user_id: user.id, post_id: post.id)
      like.save
      expect(like.post.id).to eq(post.id)
    end
  end
end
