require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }

  let(:user1) do
    User.create(name: 'Dan',
                email: 'dan@email.com',
                password: 'password',
                password_confirmation: 'password')
  end

  let(:post1) do
    user1.posts.create(content: 'Test')
  end

  describe 'Model' do
    it 'should exist' do
      expect(user).not_to be_nil
    end
  end

  describe 'Fill id automatically using association' do
    it 'creates a post' do
      user1.posts.create(content: 'abc')
      expect(user1.posts.first).not_to be_nil
    end
  end

  describe 'Fill id automatically using association' do
    it 'creates a comment' do
      post1.comments.create(user_id: 1, content: 'abc')
      expect(post1.comments).not_to be_nil
    end
  end

  describe 'Can leave likes' do
    it 'leaves a like' do
      user1.likes.create(post_id: 1)
      expect(post1.likes).not_to be_nil
    end
  end

  describe 'associations' do
    
    it { should have_many(:comments) }
    
    it { should have_many(:posts) }

    it { should have_many(:confirmers) }

    it { should have_many(:requesters) }
  end
end