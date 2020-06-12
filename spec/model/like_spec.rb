require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) { User.create(name: 'test', email: 'email@email.com', password: 'abc123') }
  let(:post1) { user1.posts.create(content: 'abc') }
  let(:comment1) { post1.comments.create(user_id: 1, content: 'abc') }
  let(:like1) { user1.likes.create(post_id: 1) }

  context 'check associations' do
    it 'retrieve user who leave the like' do
      user1
      post1
      comment1
      like1
      expect(Like.first.user_id).not_to be_nil
    end
  end
end
