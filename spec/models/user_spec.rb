require 'rails_helper'

describe User, type: :model do
  fixtures :users
  # it 'is valid with all attributes' do
  #   expect(User.new(name: 'wandji', email: 'wandji@email', password: '111111')).to be_valid
  # end
  # it 'is not valid with name longer than 20 characters' do
  #   expect(User.new(name: 'wandjirrrrrrrrrrttttttt', email: 'wandji@email', password: '111111')).to_not be_valid
  # end
  # let(:user) { User.new(name: 'wandjir', email: 'wandji@email', password: '111111')}
  it 'returns true for a valid user' do
    user1 = users(:user1)
    expect(user1.valid?).to be true
  end

  it 'returns false for an name is more than 20 characters' do
    user3 = users(:user3)
    expect(user3.valid?).to be false
  end

  it 'invalid if email already exit' do
    user = User.new(name: 'wand', email: 'wandji@email.com')
    expect(user.valid?).to be false
  end
end
