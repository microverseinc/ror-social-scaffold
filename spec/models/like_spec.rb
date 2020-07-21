require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'Like model' do
    let(:user) { User.new(name: 'tester', email: 'test@tester.com', password: 'password123') }
    let(:post) { Post.new(content: 'This is my post') }
    let(:like) { Like.new }
    it 'VALID with the user and post' do
      user.save
      post.save
      post.user = user
      like.post = post
      like.user = user
      expect(like).to be_valid
    end

    it 'INVALID without user' do
      user.save
      post.save
      post.user = user
      like.post = post
      like.user = nil
      expect(like).not_to be_valid
    end

    it 'INVALID without post' do
      user.save
      post.save
      post.user = user
      like.post = nil
      like.user = user
      expect(like).not_to be_valid
    end
  end

  context 'Associations for like' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end
end
