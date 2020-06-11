require 'rails_helper'

# rspec ./spec/model/comment_spec.rb
RSpec.describe Comment, type: :model do
  let(:user1) { User.create(name: 'test', email: 'email@email.com', password: 'abc123') }
  let(:post1) { user1.posts.create(content: 'abc') }
  let(:comment1) { post1.comments.create(user_id: 1, content: 'abc') }
  let(:like1) { user1.likes.create(post_id: 1) }

  context 'check associations' do
    it 'which post the comment belongs' do
      user1
      post1
      comment1
      like1
      expect(Comment.first.post_id).not_to be_nil
    end

    it 'who wrote the comment' do
      user1
      post1
      comment1
      like1
      expect(Comment.first.user_id).not_to be_nil
    end
  end
end
