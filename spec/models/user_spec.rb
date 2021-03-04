require 'rails_helper'

describe User, type: :model do
  fixtures :users

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

  describe 'columns for user' do
    it { should have_db_column(:email) }
    it { should have_db_column(:name) }
  end
end
