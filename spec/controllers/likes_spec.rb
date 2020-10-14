require 'rails_helper'

RSpec.describe Like, type: :model do
  User.delete_all
  Post.delete_all
  let!(:user1) { User.create(email: 'heroku@heroku', name: 'heroku', gravatar_url: 'heroku', password: '123456') }
  let!(:post1) { Post.create(content: 'Test post', user_id: user1.id) }
  let!(:like1) { Like.create(post_id: nil, user_id: nil) }
  let!(:like2) { Like.create(post_id: post1.id, user_id: user1.id) }

  it 'Checks for a user to exist to create a like.' do
    expect(like1).to be_invalid
  end

  it 'Cheks if the users does exist, and allows the like' do
    expect(like2).to be_valid
  end
end
