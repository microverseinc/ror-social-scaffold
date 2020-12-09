require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'Create a new data container' do
    user = User.new(name: 'abc', email: 'a@a.com')
    expect(user).to be_a_new(User)
  end

  it 'User is valid if a name attribute is present' do
    user = User.new(name: 'abc', email: 'a@a.com', password: '123456')
    expect(user).to be_valid
  end

  it 'User is not valid without name attribute' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it 'User has many posts' do
    expect(User.reflect_on_association(:posts).macro).to eq(:has_many)
  end

  it 'User has many likes' do
    expect(User.reflect_on_association(:likes).macro).to eq(:has_many)
  end

  it 'User has many comments' do
    expect(User.reflect_on_association(:comments).macro).to eq(:has_many)
  end

  it 'User has many friendships' do
    expect(User.reflect_on_association(:friendships).macro).to eq(:has_many)
  end

  it 'User has many friends' do
    expect(User.reflect_on_association(:friends).macro).to eq(:has_many)
  end

  it 'User has many friendship requests' do
    expect(User.reflect_on_association(:friendships_received).macro).to eq(:has_many)
  end

  it 'User has many friends through friend requests' do
    expect(User.reflect_on_association(:received_friends).macro).to eq(:has_many)
  end
end
