require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures name presence' do
      user = User.new(name: 'spetsnaz', email: 'temple@yahoo.com', password: 'precious5').save
      expect(user).to eql(true)
    end

    it 'ensures password is at least 6 characters' do
      user = User.new(name: 'spetsnaz', email: 'temple@yahoo.com', password: 'preci').save
      expect(user).to eql(false)
    end

    it 'ensures email must be unique' do
      User.new(name: 'louis', email: 'temple@yahoo.com', password: 'precious5').save
      user = User.new(name: 'spetsnaz', email: 'temple@yahoo.com', password: 'precious5').save
      expect(user).to eql(false)
    end

    it 'does not ensure uniqueness of name' do
      User.new(name: 'spetsnaz', email: 'louis@yahoo.com', password: 'precious5').save
      user = User.new(name: 'spetsnaz', email: 'temple@yahoo.com', password: 'precious5').save
      expect(user).to eql(true)
    end

    it 'ensures password must be present' do
      user = User.new(name: 'spetsnaz', email: 'temple@yahoo.com').save
      expect(user).to eql(false)
    end

    it 'ensures email must be present' do
      user = User.new(name: 'spetsnaz', password: 'precious5').save
      expect(user).to eql(false)
    end

    it 'ensures name must be unique' do
      user = User.new(email: 'temple@yahoo.com', password: 'precious5').save
      expect(user).to eql(false)
    end
  end
end
