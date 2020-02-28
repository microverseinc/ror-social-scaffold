require 'rails_helper'

RSpec.describe 'Post Model', type: :model do
  describe 'validations' do
    let(:user) do
      User.new(
        name: 'john',
        email: 'john@gmail.com',
        password: 'password'
      )
    end
    let(:post) do
      Post.new(
        content: 'This is a new post',
        user_id: user.id
      )
    end

    before(:each) do
      user.save
    end

    it 'is valid with valid attributes' do
      expect(post.valid?).to eq(true)
      expect(post.save).to eq(true)
    end

    it 'is invalid with invalid content' do
      post.content = ''
      expect(post.valid?).not_to eq(true)
      expect(post.save).not_to eq(true)
    end

    it 'is invalid with a too long content' do
      post.content = '*' * 1001
      expect(post.valid?).not_to eq(true)
      expect(post.save).not_to eq(true)
    end

    it 'is invalid with invalid user' do
      post.user_id = ''
      expect(post.valid?).not_to eq(true)
      expect(post.save).not_to eq(true)
    end

    it 'belongs to one user' do
      post.save
      expect(post.user.name).to eq(user.name)
    end

    it 'is has many comments' do
      post.save
      2.times do
        Post.last.comments.create(content: 'This is a new comment', user_id: user.id)
      end
      expect(post.comments.count).to eq(2)
      expect(post.comments.first.user.name).to eq(user.name)
    end
  end
end
