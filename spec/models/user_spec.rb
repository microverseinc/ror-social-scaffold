require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.create(
      email: 'user@example.com',
      name: 'User',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  let(:user2) do
    User.create(
      email: 'friend@example.com',
      name: 'Friend',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  describe 'validations' do
    it 'should not be valid without a name' do
      user.name = nil
      expect(user).to_not be_valid
    end

    it 'should have a name less than 20 characters' do
      user3 = User.create(name: 'a' * 21)

      expect(user).to be_valid
      expect(user3).to_not be_valid
    end
  end

  describe 'associations' do
    it 'can have many posts' do
      expect(user).to respond_to(:posts)
    end

    it 'can have many comments' do
      expect(user).to respond_to(:comments)
    end

    it 'can have many likes' do
      expect(user).to respond_to(:likes)
    end
  end
end
