require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
  end

  context 'Validations' do
    it 'should not be valid without all attributes' do
      user = User.new(name: nil, email: nil, password: nil)
      expect(user).to_not be_valid
    end

    it 'should be valid if provided all attributes' do
      user = User.new(name: 'joxy', email: 'joxy@gmail.com', password: 'joxy12')
      expect(user).to be_valid
    end

    it 'should not be valid if email exist' do
      User.create(email: 'dede@gmail.com')
      user2 = User.new(email: 'dede@gmail.com')
      expect(user2).to_not be_valid
    end
  end
end
