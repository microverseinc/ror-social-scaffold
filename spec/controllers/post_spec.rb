require 'rails_helper'

RSpec.describe Post, type: :model do
  User.delete_all
  Post.delete_all
  let!(:user1) { User.create(email: 'heroku@heroku', name: 'heroku', gravatar_url: 'heroku', password: '123456') }
  let!(:post1) { Post.create(content: 'Test post', user_id: user1.id) }
  let!(:post2) { Post.create(content: nil, user_id: nil) }

  it 'checks if a post can be saved' do
    expect(post2).to be_invalid
  end

  it 'checks if a post can be saved' do
    expect(post1).to be_valid
  end
end
