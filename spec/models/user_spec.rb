require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new

  it 'is valid when the values are present' do
    user.name = 'User1'
    user.email = 'user@email.com'
    user.password = 'password'
    expect(user).to be_valid
  end

  it 'is valid when name is present' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'checks email uniquness' do
    user2 = User.create(name: 'Juan andres', email: 'alex@gmail.com', password: 'secretpass',
                        password_confirmation: 'secretpass')
    user2.valid?
    expect(user2.valid?).to eql(true)

    user2 = User.create(name: 'joha', email: 'joha.email@email.com', password: 'secretpass',
                        password_confirmation: 'secretpass')
    expect(user2.valid?).to eql(true)
  end
end
