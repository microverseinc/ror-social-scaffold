require 'rails_helper'

# rspec ./spec/model/user_spec.rb
RSpec.describe User, type: :model do
  let(:user) { User.new}
  let(:user1) { User.create(name: 'test', email: 'email@email.com', password: 'abc123') }
  let(:post1) { user1.posts.create(content: 'abc') }

  context 'Model' do
    it 'should exist' do
      expect(user).not_to be_nil
    end
  end

  context 'Autofill id using association' do 
    it 'create a post' do
      user1.posts.create(content: 'abc')
      expect(user1.posts.first).not_to be_nil
    end
  end

  context 'Autofill id using association' do 
    it 'create a comment' do
      post1.comments.create(user_id: 1, content: 'abc')
      expect(post1.comments).not_to be_nil
    end
  end

  # TODO: can leave a like
  context 'etc' do
    it 'leave a like' do
      user1.likes.create(post_id: 1)
      expect(post1.likes).not_to be_nil
    end
  end
end
