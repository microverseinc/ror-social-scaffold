require 'rails_helper'

RSpec.describe Friendship, type: :model do
  unconfirmed_friendship_one = Friendship.new(user_id: 34, friend_id: 45)
  it 'status is false' do
    expect(unconfirmed_friendship_one.status).to be false
  end

  describe 'associations for friendship' do
    it { should belong_to(:user) }
  end

  unconfirmed_friendship_two = Friendship.new(user_id: 43, friend_id: 50)
  unconfirmed_friendship_two.update({ status: true })
  it 'status is true' do
    expect(unconfirmed_friendship_two.status).to be true
  end
end
