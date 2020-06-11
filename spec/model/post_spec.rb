require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user1) { User.create(name: 'test', email: 'email@email.com', password: 'abc123') }
  let(:post1) { user1.posts.create(content: 'abc') }
  let(:comment1) { post1.comments.create(user_id: 1, content: 'abc') }
  let(:like1) { user1.likes.create(post_id: 1) }

  context 'check associations' do
    it 'retrieve user who wrote the post' do
      user1
      post1
      expect(user1.posts.first).not_to be_nil
    end

    it 'retrieve post comments' do
      user1
      post1
      comment1
      expect(Post.first.comments).not_to be_nil
    end

    it 'should exist a like' do
      user1
      post1
      comment1
      like1
      expect(Post.first.likes).not_to be_nil
    end
  end
end
