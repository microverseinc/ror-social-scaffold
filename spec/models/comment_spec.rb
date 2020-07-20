require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) do
    User.create(name: 'test_user', email: 'test_user@test.com',
                password: '123456', password_confirmation: '123456')
  end
  let(:post) do
    Post.create(user_id: user.id, content: 'This is a post created for the
      purpose of testing the post model.')
  end
  subject do
    Comment.new(user_id: user.id, post_id: post.id, content:
                'This is a comment for the post made.')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid when content is blank' do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid when content lenght is more than 200 characters' do
    subject.content = 'a' * 201
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
