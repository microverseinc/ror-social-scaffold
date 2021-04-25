require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { User.new(name: 'Doe', email: 'doe@mail.com', password: 'password') }
  let(:friend) { User.new(name: 'Jon', email: 'jon@mail.com', password: 'password') }
  let(:friendship) { Friendship.create(user: user, friend: friend) }

  it 'creates a valid friendship' do
    expect(friendship.valid?).to be true
  end

  it 'sends a friendship correctly' do
    expect(user.sent_requests.include?(friendship)).to be true
  end

  it 'receives a friendship correctly' do
    expect(friend.received_requests.include?(friendship)).to be true
  end

  it 'creates a friendship through user' do
    new_friendship = user.sent_requests.build(user: user, friend: friend)
    expect(new_friendship.valid?).to be true
  end
end
