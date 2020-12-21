require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.create(name: 'User test like', email: 'user@gmail.com',
                password: 'password', password_confirmation: 'password')
  end
  let(:post) do
    Post.create(user_id: user.id, content: 'this is a post for test the comment model.')
  end
  subject do
    Comment.create(user_id: user.id, post_id: post.id,
                   content: 'this is a comment for the last post')
  end
  it 'validates the correct attributes' do
    expect(subject).to be_valid
  end
  it 'is invalid whien the content is blank or empty' do
    subject.content = nil
    expect(subject).to_not be_valid
  end
  it 'is invalid when the content is more than 200 characters' do
    subject.content = 'a' * 201
    expect(subject).to_not be_valid
  end
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
