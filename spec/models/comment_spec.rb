require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  context 'Validations' do
    it 'should not be valid if a user is not logged in' do
      comment = Comment.new(content: 'hello from us')
      expect(comment.valid?).to be false
    end

    user = User.first || User.create(name: 'dave', email: 'dave@gmail.com', password: '123456')
    post = Post.create(user_id: user.id, content: 'hello here')
    it 'should post if is a logged in user' do
      comment = Comment.new(user_id: user.id, post_id: post.id, content: 'hello from us')
      expect(comment).to be_valid
    end
  end
end
