require 'rails_helper'
RSpec.describe Post, type: :model do
  context 'Posts/Comments relations' do
    it 'Checks associations between Posts and Comments' do
      user = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      post = Post.create!(content: 'post test', user_id: user.id)
      comment = Comment.create!(content: 'first comment', user_id: user.id, post_id: post.id)
      expect(post.comments).to eq([comment])
    end
  end

  context 'Post validation' do
    it 'Checks Post model validations' do
      user = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      post = Post.create!(content: 'post test', user_id: user.id)
      expect(Post.all).to eq([post])
    end
  end
end
