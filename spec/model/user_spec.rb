require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships).class_name('Friendship') }

    it 'returns true if user was created correctly' do
      user = User.create(email: 'user1@gmail.com', password: 'password', name: 'User')
      expect(user).to be_truthy
    end

    it 'returns nil if user was created incorrectly' do
      user = User.create(email: 'user1gmail.com', password: 'password', name: 'User')
      expect(user.id).to be_falsey
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name) }
  end
end
