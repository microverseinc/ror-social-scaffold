require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Post model'
  let(:user) { User.new(name: 'test', email: 'test@email.com', password: 'testing') }
  let(:post) { Post.new(content: 'This is a test!') }

  it 'INVALID of content empty' do
    user.save
    post.user = user
    post.content = ''
    expect(post).not_to be_valid
  end

  it 'VALID if created by user' do
    user.save
    post.user = user
    expect(post).to be_valid
  end
end
