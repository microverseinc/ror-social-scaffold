require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with all fields valid' do
      subject.email = 'example@mail.com'
      subject.name = 'example_name'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      expect(subject).to be_valid
    end

    it 'is not valid without a password' do
      subject.email = 'example@mail.com'
      subject.name = 'example_name'
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.name = 'example_name'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a name' do
      subject.email = 'example@mail.com'
      subject.password = 'password'
      subject.password_confirmation = 'password'
      expect(subject).to_not be_valid
    end

    it 'is not valid without a password confirmation' do
      subject.email = 'example@mail.com'
      subject.name = 'example_name'
      subject.password = 'password'
      expect(subject).to_not be_valid
    end
  end

  context 'testing associations User' do
    it 'has many posts' do
      x = User.reflect_on_association(:posts)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many comments' do
      x = User.reflect_on_association(:comments)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many likes' do
      x = User.reflect_on_association(:likes)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many friendships' do
      x = User.reflect_on_association(:friendships)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many comments' do
      x = User.reflect_on_association(:inverse_friendships)
      expect(x.macro).to eq(:has_many)
    end
  end
end
