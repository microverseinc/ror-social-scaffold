require 'rails_helper'

RSpec.describe 'User Model', type: :model do
  describe 'validations' do
    let(:user) do
      User.new(
        name: 'john',
        email: 'john@gmail.com',
        password: 'password'
      )
    end

    it 'is valid with valid attributes' do
      expect(user.valid?).to eq(true)
      expect(user.save).to eq(true)
    end

    it 'is invalid with invalid name' do
      user.name = ''
      expect(user.valid?).not_to eq(true)
      expect(user.save).not_to eq(true)
    end

    it 'is invalid with invalid email' do
      user.email = ''
      expect(user.valid?).not_to eq(true)
      expect(user.save).not_to eq(true)
    end

    it 'is invalid with invalid password' do
      user.password = ''
      expect(user.valid?).not_to eq(true)
      expect(user.save).not_to eq(true)
    end

    it 'is has many posts' do
      user.save
      2.times do
        Post.create(content: 'This is a new post', user_id: user.id)
      end
      expect(user.posts.count).to eq(2)
      expect(user.posts.first.user_id).to eq(user.id)
    end

    it 'is has many comments' do
      user.save
      2.times do
        Post.create(content: 'This is a new post', user_id: user.id)
      end
      2.times do
        Post.last.comments.create(content: 'This is a new comment', user_id: user.id)
      end
      expect(user.comments.count).to eq(2)
      expect(user.posts.last.comments.first.user.name).to eq(user.name)
    end
  end
end
