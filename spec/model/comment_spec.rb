require 'rails_helper'

RSpec.describe Comment, type: :Comment do
  let(:user1) { User.create(name: 'Oscar', email: 'a@mail.com', password: '123456') }
  let(:post1) { Post.create(content: 'Content of an amazing post') }
  subject { Comment.new(user: user1, post: post1, content: 'Amazing comment') }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end
  it 'shold belongs to user' do
    Comment.reflect_on_association(:User)
  end
  it 'shold belongs to post' do
    Comment.reflect_on_association(:Post)
  end
end
