require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations for users' do
    it 'Validates presence of username' do
      user = User.new
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'Validates presence of email' do
      user = User.new
      user.name = 'yahir'
      user.email = nil
      user.password = 'password'
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'Validates presence of password' do
      user = User.new
      user.name = 'yahir'
      user.password = ''
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end
  end
end
