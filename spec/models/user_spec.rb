require './rails_helper'

describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(User.new).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  context 'validations' do
    before { create(:user) }

    context 'presence' do
      it { should validate_presence_of :name }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of :name }
    end

    it 'is database authenticable' do
      user = User.create(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user.valid_password?('password123')).to be_truthy
    end
  end

  context 'associations' do
    it { should have_many(:posts).class_name('Post') }
    it { should have_many(:friends).class_name('Friendship') }
  end


end
