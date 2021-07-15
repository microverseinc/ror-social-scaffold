require 'rails_helper'
RSpec.describe Comment, type: :model do
  context 'Comment validation' do
    it 'Checks Comment model validations' do
      user = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      post = Post.create!(content: 'post test', user_id: user.id)
      comment = Comment.create!(content: 'first comment', user_id: user.id, post_id: post.id)
      expect(Comment.all).to eq([comment])
    end
  end
end
