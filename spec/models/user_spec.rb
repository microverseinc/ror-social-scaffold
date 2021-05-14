require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }
  let(:invalid_user) { User.create(name: '', email: 'test@example.com', password: 'password') }
  let(:posts) { User.reflect_on_association(:posts).macro }
  let(:comments) { User.reflect_on_association(:comments).macro }
  let(:likes) { User.reflect_on_association(:likes).macro }
  let(:friendships) { User.reflect_on_association(:friendships).macro }
  let(:inverse_friendships) { User.reflect_on_association(:inverse_friendships).macro }

  it 'checks for the  user validity' do
    @user = User.create(name: 'test', email: 'test@example.com', password: 'password')
    expect(@user).to be_valid
  end

  it 'user name should not be empty' do
    expect(invalid_user).to_not be_valid
  end

  it 'checks for correct post association' do
    expect(posts).to eq(:has_many)
  end

  it 'check for the correct comment association' do
    expect(comments).to eq(:has_many)
  end

  it 'check for the correct  likes association' do
    expect(likes).to eq(:has_many)
  end

  it 'check for the correct friendship association' do
    expect(friendships).to eq(:has_many)
  end

  it 'check for the correct inverse_friendships association' do
    expect(inverse_friendships).to eq(:has_many)
  end
end
