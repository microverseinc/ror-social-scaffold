require 'rails_helper'

RSpec.describe User, type: :model do
  # tests
  context 'validation' do
    subject do
      described_class.new(name: 'Sercan', email: 'sercan@gmail.com',
                          password: '123456', password_confirmation: '123456')
    end

    it 'Is it valid with requirements' do
      expect(subject).to be_valid
    end

    it 'It is not valid without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Is not valid without email' do
      subject.email = 'visva.com'
      expect(subject).to_not be_valid
    end
  end

  # Associations testing
  context 'Association' do
    it 'User has many posts' do
      u = User.reflect_on_association(:posts)
      expect(u.macro).to eq(:has_many)
    end

    it 'should have many comments' do
      u = User.reflect_on_association(:comments)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many likes' do
      u = User.reflect_on_association(:likes)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many friendships' do
      u = User.reflect_on_association(:friendships)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many friends' do
      u = User.reflect_on_association(:friends)
      expect(u.macro).to eq(:has_many)
    end
  end
end
