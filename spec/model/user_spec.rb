require 'rails_helper'

# rspec ./spec/model/user_spec.rb
RSpec.describe User, type: :model do
  let(:user) { User.new}
  let(:user1) { User.create(
    name: 'test', email: 'email@email.com', password: 'abc123'
  )}

  context 'Model' do
    it 'should exist' do
      expect(user).not_to be_nil
    end
  end

  context 'Associations' do 
    it 'user can create a post' do
      user1.posts.create(content: 'abc')
      expect(user1.posts.first).not_to be_nil
    end
  end

  # TODO: can create a post

  # TODO: can create a comment

  # TODO: can leave a like
end
