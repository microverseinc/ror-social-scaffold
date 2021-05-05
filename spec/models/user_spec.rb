require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user5 = User.create!(id: 100, name: 'bruno', email: 'bruno@gmail.com', password: '123456',
                          password_confirmation: '123456')
  end

  it 'should have valid attributes' do
    expect(@user5).to be_valid
  end

  it 'should find user by email' do
    expect(User.find_by_email('isma@gmail.com')).to eq(@user)
  end

  it 'is not valid without an email' do
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end

  describe 'Associations' do
    it { should have_many(:friendships) }
  end

  describe 'Associations' do
    it { should have_many(:friends) }
  end
end
