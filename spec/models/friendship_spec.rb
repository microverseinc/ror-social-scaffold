require 'rails_helper'
RSpec.describe Friendship, type: :model do
  it 'Ensures friendship is valid if right parameters are passed' do
    a = Friendship.new(user_id: 1, friend_id: 2, confirmed: false)

    expect(a).to be_valid
  end

  it 'Ensures valid friend id is passed in' do
    a = Friendship.new(user_id: 1, confirmed: false)

    expect(a).to be_invalid
  end
end
