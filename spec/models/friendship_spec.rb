require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'Creating friendships' do
    first_user = User.new(name: 'Foobar', email: 'foo@bar.com', password: 'foobar')
    if first_user.valid?
      first_user.save
      second_user = User.new(name: 'Foobar', email: 'foo1@bar.com', password: 'foobar')
      second_user.save
    else
      first_user = User.first
      second_user = User.second
    end

    it 'must create a friendship between two users' do
      friendship = Friendship.new(user_id: first_user.id, friend_id: second_user.id, confirmed: true)
      friendship.save
      expect(friendship.valid?).to be true
    end
  end
end
