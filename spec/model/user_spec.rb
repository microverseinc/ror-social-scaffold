require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new}
  let(:user1) { User.create(name: 'test', email: 'test@rspec.com', password: 'bababa')}
  context 'Testing for model presence' do
    it 'Tests if model is valid' do
      expect(user).not_to be_nil
    end
  end

  context 'Testing for post relation (action: create)' do 
    it 'Tests if User can create a Post' do
      user1.posts.create(content: 'Test is going okay so far')
      expect(user1.posts.first).not_to be_nil
    end
  end
end
