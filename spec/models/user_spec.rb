require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(name: 'JohnDoe', email: 'johndoe@ymail.com', password: 'password') }

  context 'it has name, email and password' do
    it 'has to have a name' do
      expect(user.name).to eq('JohnDoe')
    end

    it 'it has to have an email' do
      expect(user.email).to eq('johndoe@ymail.com')
    end

    it 'it has to have a password' do
      expect(user.password).to eq('password')
    end
  end

  context 'it has to return an error for missing fields' do
    it 'returns an error for missing name' do
      user.name = nil
      expect(user.save).to eq(false)
    end

    it 'returns an error for missing email' do
      user.email = nil
      expect(user.save).to eq(false)
    end

    it 'returns an error for missing password' do
      user.password = nil
      expect(user.save).to eq(false)
    end
  end
end
