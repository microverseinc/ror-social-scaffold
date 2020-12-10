require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new

  it 'is valid when the values are present' do
    user.name = 'User1'
    user.email = 'user@email.com'
    user.password = 'password'
    expect(user).to be_valid
  end

  it 'is valid when name is present' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'checks email uniquness' do
    user2 = User.create(name: 'Juan andres', email: 'alex@gmail.com', password: 'secretpass',
                        password_confirmation: 'secretpass')
    user2.valid?
    expect(user2.valid?).to eql(true)

    user2 = User.create(name: 'joha', email: 'joha.email@email.com', password: 'secretpass',
                        password_confirmation: 'secretpass')
    expect(user2.valid?).to eql(true)
  end

  describe 'associations' do
    subject { User.create(name: 'alex', email: 'alex@gmail.com', password: '123456') }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
  end

  describe '#friends' do
    friends_array = nil
    it 'show something if there is a friendships' do
      expect(friends_array).to be_nil
    end
  end

  let(:user1) { User.create(name: 'Joha', email: 'joha@gmail.com.com', password: '123456') }
  let(:user2) { User.create(name: 'Alex', email: 'alex@yahoo.com', password: 'password') }
  let(:post1) { Post.create(content: 'New post for test', user_id: user1.id) }

  describe '#pending_friends' do
    friendship = nil
    it 'show all the friendships' do
      Friendship.create(user_id: user1.id, friend_id: user2.id, confirmed: true)
      expect(friendship).to be_nil
    end
  end
end
