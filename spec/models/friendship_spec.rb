require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'Create a new data container' do
    friendship = Friendship.new(user_id: 1, friend_id: 2)
    expect(friendship).to be_a_new(Friendship)
  end

  it 'Friendship belongs to a user' do
    expect(Friendship.reflect_on_association(:user).macro).to eq(:belongs_to)
  end

  it 'Friendship belongs to a friend' do
    expect(Friendship.reflect_on_association(:friend).macro).to eq(:belongs_to)
  end
end
