require 'rails_helper'

RSpec.describe Comment, type: :model do
  User.delete_all
  Post.delete_all
  let!(:comment1) { Comment.create(post_id: nil, user_id: nil, content: nil) }
  let!(:user1) { User.create(email: 'heroku@heroku', name: 'heroku', gravatar_url: 'heroku', password: '123456') }
  let!(:post1) { Post.create(content: 'Test post', user_id: user1.id) }

  it 'Comment creation fails with wrong parameters' do
    expect(comment1).to be_invalid
  end

  it 'Comment creation succeeds with valid parameters' do
    expect(Comment.create(post_id: post1.id, user_id: user1.id, content: 'Test comment')).to be_valid
  end
end
