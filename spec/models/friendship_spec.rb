require 'rails_helper'

RSpec.describe 'Friendship', type: :model do
  let(:user1) { User.create(
    name: "john",
    email: "john@gmail.com",
    password: "password"
  ) }

  let(:user2) { User.create(
    name: "jane",
    email: "jane@gmail.com",
    password: "password"
  ) }

  it 'relation gets created with valid params' do
    friendship = Friendship.create(friendable_id: user1.id, friend_id: user2.id)
    expect(friendship.valid?).to be(true)
  end

  it 'relation gets not created with invalid params' do
    friendship = Friendship.create(friendable_id: '', friend_id: user2.id)
    expect(friendship.valid?).to be(false)
    friendship = Friendship.create(friendable_id: user1.id, friend_id: '')
    expect(friendship.valid?).to be(false)
    friendship = Friendship.create(friendable_id: '', friend_id: '')
    expect(friendship.valid?).to be(false)
  end
end