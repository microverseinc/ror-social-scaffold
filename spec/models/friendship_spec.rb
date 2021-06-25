require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@test.com', password: '123456') }
  let(:friend) { User.create(name: 'test2', email: 'test2@test.com', password: '123456') }

  it 'is not valid with valid attributes' do
    expect(Friendship.new).not_to be_valid
  end

  it 'is valid with valid attributes' do
    expect(Friendship.new(user: user, friend: friend)).to be_valid
  end
end
