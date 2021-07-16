require 'rails_helper'
RSpec.describe User, type: :model do
  context 'User/Posts relations' do
    it 'Checks associations between User and Posts' do
      user = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      post = Post.create!(content: 'post test', user_id: user.id)
      expect(user.posts).to eq([post])
    end
  end

  context 'User validation' do
    it 'Checks User model validations' do
      user = User.create!(email: 'test@email.com', name: 'testname', password: 'testpassword')
      expect(User.all).to eq([user])
    end
  end
end
