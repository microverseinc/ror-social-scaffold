require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    let(:user) do
      User.create(name: 'Magz',
                  email: 'magz@example.com',
                  password: '123456',
                  password_confirmation: '123456')
    end
    it 'is valid with all fields valid' do
      subject.user_id = user.id
      subject.content = 'This is a validation post'
      expect(subject).to be_valid
    end

    it 'is not valid without content' do
      subject.content = ''
      expect(subject).to_not be_valid
    end
  end

  context 'testing associations Post' do
    it 'has many likes' do
      x = Post.reflect_on_association(:likes)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many comments' do
      x = Post.reflect_on_association(:comments)
      expect(x.macro).to eq(:has_many)
    end

    it 'belongs to user' do
      x = Post.reflect_on_association(:user)
      expect(x.macro).to eq(:belongs_to)
    end
  end
end
