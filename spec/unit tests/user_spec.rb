require 'rails_helper'
RSpec.describe User do
  describe 'create and update user' do
    it 'rejects request if name is missing' do
      user = User.new(name: '', email: 'example001@example.com',
                      password: 'Secret1', password_confirmation: 'Secret1')
      expect(user.valid?).to eq(false)
    end
    it 'rejects request if name is too short' do
      user = User.new(name: 'Ur', email: 'example001@example.com',
                      password: 'Secret1', password_confirmation: 'Secret1')
      expect(user.valid?).to eq(false)
    end
    it 'rejects request if name is too long' do
      user = User.new(name: 'José María del Valle y de todos los Santos', email: 'example001@example.com',
                      password: 'Secret1', password_confirmation: 'Secret1')
      expect(user.valid?).to eq(false)
    end
    it 'rejects request if email is missing' do
      user = User.new(name: 'John', email: '',
                      password: 'Secret1', password_confirmation: 'Secret1')
      expect(user.valid?).to eq(false)
    end
    it 'rejects request if email formatted the wrong way' do
      user = User.new(name: 'John', email: 'example001_example.com',
                      password: 'Secret1', password_confirmation: 'Secret1')
      expect(user.valid?).to eq(false)
    end
    it 'rejects request if password is missing' do
      user = User.new(name: 'John', email: 'example001@example.com',
                      password: '', password_confirmation: 'Secret1')
      expect(user.valid?).to eq(false)
    end
    it 'rejects request if password confirmation is missing' do
      user = User.new(name: 'John', email: 'example001@example.com',
                      password: 'Secret1', password_confirmation: '')
      expect(user.valid?).to eq(false)
    end
    it 'rejects request if password confirmation is different to password' do
      user = User.new(name: 'John', email: 'example001@example.com',
                      password: 'Secret1', password_confirmation: 'Secret2')
      expect(user.valid?).to eq(false)
    end
    it 'accepts the request if data is valid' do
      user = User.new(name: 'John', email: 'example001@example.com',
                      password: 'Secret1', password_confirmation: 'Secret1')
      expect(user.valid?).to eq(true)
    end
  end
end
