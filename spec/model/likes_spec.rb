require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) { User.create(name: 'Oscar', email: 'a@mail.com', password: '123456') }
  let(:post1) { Post.create(content: 'Content of an amazing post') }
  subject { Like.create(post: post1, user: user1) }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid if it takes an already created post_id and user_id combination' do
    Like.create(post: post1, user: user1)
    expect(subject).to_not be_valid
  end
  it 'should belongs to user' do
    Like.reflect_on_association(:User)
  end
  it 'should belongs to post' do
    Like.reflect_on_association(:Post)
  end
end
