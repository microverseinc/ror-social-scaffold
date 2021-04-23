require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'creates a valid like' do
    user = User.new(name: 'Doe', email: 'doe@mail.com', password: 'password')
    post = Post.create(content: 'Hello!', user: user)
    like = Like.create(user: user, post: post)
    expect(like.valid?).to be true
  end
end
