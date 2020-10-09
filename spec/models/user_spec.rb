require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(id: '1', name: 'Ramin', email: 'ramin@ramin.com', password: '123456') }
  context 'should create new user' do
    it 'should return user name' do
      expect(user.name).to eq('Ramin')
    end
    it 'should return user email' do
      expect(user.email).to eq('ramin@ramin.com')
    end
    it 'should return user id' do
      expect(user.id).to eq(1)
    end
    it 'should create new user' do
      expect(user.password).to eq('123456')
    end
  end

  context 'Asociations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
  end
end
