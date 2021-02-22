require 'rails_helper'

RSpec.describe 'Friendship', type: :model do
  let(:user1) { User.create(name: 'rspec1', email: 'rspec1@test.com', password: '123456') }
  let(:user2) { User.create(name: 'rspec2', email: 'rspec2@test.com', password: '123456') }
  let(:friendship) { Friendship.create(user_id: user1.id, friend_id: user2.id, confirmed: false) }
  let(:inv_friendship) { Friendship.create(user_id: '', friend_id: user1.id, confirmed: false) }
  let(:user) { Friendship.reflect_on_association(:user).macro }
  let(:friend) { Friendship.reflect_on_association(:friend).macro }

  it 'checks if creating friendship is correct' do
    expect(friendship).to be_valid
  end

  it 'check for not valid friendship' do
    expect(inv_friendship).to_not be_valid
  end

  it 'checks if friendship belongs_to user' do
    expect(user).to eq(:belongs_to)
  end

  it 'checks if friendship belongs_to friend' do
    expect(friend).to eq(:belongs_to)
  end
end
