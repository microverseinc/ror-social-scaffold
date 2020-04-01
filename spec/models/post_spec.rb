require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'JohnDoe', email: 'johndoe@ymail.com', password: 'password') }
  let(:post) { Post.new(content: 'A simple post content', user_id: user.id) }

  it 'has to have a content' do
    expect(post.content).to eq('A simple post content')
  end
  it 'has to have a user_id' do
    expect(post.user_id).to eq(user.id)
  end
  it 'returns an error for missing content' do
    post.content = nil
    expect(post.save).to eq(false)
  end
  it 'returns an error for missing user_id' do
    post.user_id = nil
    expect(post.save).to eq(false)
  end
end
