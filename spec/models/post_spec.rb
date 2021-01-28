require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  context 'Validations' do
    user = User.first || User.create(name: 'dave', email: 'dave@gmail.com', password: '123456')
    it 'should post if is a logged in user' do
      post = Post.new(user_id: user.id, content: 'hello from us')
      expect(post.valid?).to be true
    end

    it 'should not be valid if a user is not logged in' do
      post = Post.new(content: '')
      expect(post.valid?).to be false
    end
  end
end
