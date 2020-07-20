require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }
  let(:user1) { User.create(name: 'test', email: 'email@email.com', password: 'abc123') }
  let(:post1) { user1.posts.create(content: 'abc') }

  context 'Model' do
    it 'should exist' do
      expect(user).not_to be_nil
    end
  end

  context 'Autofill id using association' do
    it 'create a post' do
      user1.posts.create(content: 'abc')
      expect(user1.posts.first).not_to be_nil
    end
  end

  context 'Autofill id using association' do
    it 'create a comment' do
      post1.comments.create(user_id: 1, content: 'abc')
      expect(post1.comments).not_to be_nil
    end
  end

  context 'user can leave a like' do
    it 'leave a like' do
      user1.likes.create(post_id: 1)
      expect(post1.likes).not_to be_nil
    end
  end
  describe '#name' do
    it 'doesnt validate user without the name' do
      user = User.new
      user.name = nil
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")

      user.name = 'test'
      user.valid?
      expect(user.errors[:name]).to_not include("can't be blank")
    end
  end

  describe '#email' do
    it 'validates for presence of email adress' do
      user = User.new
      user.name = 'test'
      user.email = ''
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")

      user.email = 'email@gmail.com'
      user.valid?
      expect(user.errors[:email]).to_not include("can't be blank")
    end

    it 'validates for format of email adress' do
      user = User.new
      user.name = 'test'
      user.email = 'email..com'
      user.valid?
      expect(user.errors[:email]).to include('is invalid')

      user.email = 'email@gmail.com'
      user.valid?
      expect(user.errors[:email]).to_not include('is invalid')
    end
  end

  describe '#password' do
    it 'validates the presence of password' do
      user = User.new
      user.name = 'test'
      user.email = 'email@email.com'
      user.password = ''
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")

      user.password = '123456'
      expect(user.valid?).to eql(true)
    end
  end
end
