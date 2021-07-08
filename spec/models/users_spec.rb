require 'rails_helper'

describe 'Users', type: :feature do
  describe 'Creating new user' do
    it 'should not be valid without email' do
      u = User.new(name: 'Carlos', password: '123456', password_confirmation: '123456')
      expect(u.valid?).to be(false)
    end

    it 'invalid user should return errors' do
      u = User.new(name: 'Carlos', password: '123456', password_confirmation: '123456')
      u.save
      expect(u.errors.empty?).to be(false)
    end

    it 'should not save without email' do
      u = User.new(name: 'Carlos', password: '123456', password_confirmation: '123456')
      u.save
      expect(u.persisted?).to be(false)
    end

    it 'should save with correct details' do
      u = User.new(name: 'Carlos', email: 'roberto@vv.com', password: '123456', password_confirmation: '123456')
      u.save
      expect(u.persisted?).to be(true)
    end
  end
end
