require 'rails_helper'

RSpec.describe Post, type: :feature do
  before :each do
    User.create(name: 'JonDoe', email: 'jondoe@example.com', password: 'password', password_confirmation: 'password')
  end

  it 'Sends error user must exist' do
    expect(Post.create(content: 'This is a new post').errors.full_messages).to eq(['User must exist'])
  end

  it 'Creates a post' do
    user = User.last
    post = Post.create(content: 'This is a new post', user_id: user.id)
    expect(post).to eq(Post.first)
  end
end
