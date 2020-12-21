require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    user = User.new(email: 'test@testing.com', name: 'test', password: '123456')
    it 'should not be valid user without name' do
      user.name = nil
      expect(User.new).to_not be_valid
    end
  end
end

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'should be a valid user' do
      expect(User.new(name: 'test', email: 'test@testing.com', password: '123456')).to be_valid
    end
  end
end