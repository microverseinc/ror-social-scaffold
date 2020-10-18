require 'rails_helper'
RSpec.describe User, type: :model do
  user = User.create(name: 'Daniel Eze', email: 'd.email@example.com', password: 'secretpass',
                     password_confirmation: 'secretpass')
  it 'name must be present' do
    user.name = nil
    expect(user).to_not be_valid
  end
  it 'email must be present' do
    user.email = nil
    expect(user).to_not be_valid
  end
  it 'password must be present' do
    user.password = nil
    expect(user).to_not be_valid
  end
  it 'All parameters must have values' do
    user.name = 'Daniel Eze'
    user.email = 'a.email@example.com'
    user.password = 'secretpass'
    user.password_confirmation = 'secretpass'
    expect(user).to be_valid
  end
  it 'checks email uniquness' do
    user2 = User.create(name: 'Umair Eze', email: 'd.email@example.com', password: 'secretpass',
                        password_confirmation: 'secretpass')
    user2.valid?
    expect(user2.errors[:email]).to include('has already been taken')

    user2 = User.create(name: 'Umair Eze', email: 'u.email@example.com', password: 'secretpass',
                        password_confirmation: 'secretpass')
    expect(user2.valid?).to eql(true)
  end
  it 'validates password length' do
    user2 = User.create(name: 'Ken Eze', email: 'k.email@example.com', password: 'sec', password_confirmation: 'sec')
    user2.valid?
    expect(user2.errors[:password]).to include('is too short (minimum is 6 characters)')

    user2 = User.create(name: 'ken Eze', email: 'k.email@example.com', password: 'secretpass',
                        password_confirmation: 'secretpass')
    expect(user2.valid?).to eql(true)
  end
end
