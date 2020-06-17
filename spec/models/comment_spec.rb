require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user1) do
    User.create(name: 'Test',
                email: 'test@mail.com',
                password: 'password',
                password_confirmation: 'password')
  end

  let(:post1) do
    user1.posts.create(content: 'Test')
  end

  let(:comment1) do 
    post1.comments.create(user_id: 1,
                          content: 'test comments content'
                          )
  end

  it 'belongs_to user' do
    expect(post1).to eq(user1.posts.first)
  end

  it 'belongs_to post' do
    expect(comment1).to eq(post1.comments.first)
  end

  describe 'associations' do
    it { should belong_to(:user) }

    it { should belong_to(:post) }
  end
end