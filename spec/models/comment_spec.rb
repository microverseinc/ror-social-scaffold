require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'creates a valid comment' do
    user = User.new(name: 'Doe', email: 'doe@mail.com', password: 'password')
    post = Post.create(content: 'Hello!', user: user)
    comment = Comment.create(user: user, post: post, content: 'Nice post')
    expect(comment.valid?).to be true
  end

  it 'comment must have content' do
    user = User.new(name: 'Doe', email: 'doe@mail.com', password: 'password')
    post = Post.create(content: 'Hello!', user: user)
    comment = Comment.create(user: user, post: post)
    expect(comment.valid?).to be false
  end
end
