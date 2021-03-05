require 'rails_helper'

RSpec.describe 'Comment', type: :model do
  it 'is valid if the comment is present' do
    user = User.create(name: 'Rose', email: 'rosesumba6@yahoo.mail', password: 'sertot')
    post = Post.create(content: 'Where is Uhuru Kenyatta?', user_id: user.id)
    comment = Comment.create(content: 'I get so bored in the afternoon', user_id: user.id, post_id: post.id)
    expect(comment).to be_valid
  end
  it 'is invalid if the comment is not present' do
    user = User.create(name: 'Rose', email: 'rosesumba6@yahoo.mail', password: 'sertot')
    post = Post.create(content: 'Where is Uhuru Kenyatta?', user_id: user.id)
    comment = Comment.create(content: '', user_id: user.id, post_id: post.id)
    expect(comment).not_to be_valid
  end

  describe 'associations' do
    it 'belongs to post' do
      comment = Comment.reflect_on_association(:user)
      expect(comment.macro).to eql(:belongs_to)
    end
    it 'belongs to user' do
      comment = Like.reflect_on_association(:post)
      expect(comment.macro).to eql(:belongs_to)
    end
  end
end
