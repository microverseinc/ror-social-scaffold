require 'rails_helper'

RSpec.describe Friendship, type: :model do
  def different_number(options = {})
    dif_num = Random.rand(options[:min]..options[:max])
    return dif_num if dif_num != options[:than]

    different_number(than: options[:than], min: options[:min], max: options[:max])
  end

  let(:user1) { User.create(name: 'User1', email: 'user1@email.com', password: 'password') }
  let(:user2) { User.create(name: 'User2', email: 'user2@email.com', password: 'password') }

  it 'needs valid sender' do
    invalid_friendship = Friendship.new(user_id: user1.id, friend_id: different_number(than: user2.id, min: 1, max: 100))
    expect(invalid_friendship.valid?).to be false
  end

  it 'needs valid reciever' do
    invalid_friendship = Friendship.new(user_id: different_number(than: user2.id, min: 1, max: 100), friend_id: user2.id)
    expect(invalid_friendship.valid?).to be false
  end
end
