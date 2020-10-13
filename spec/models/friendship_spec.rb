# rubocop: disable Layout/LineLength

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let!(:user_one) { User.create(name: 'Miguel', email: 'Cervantez@gmail', password: '212322', gravatar_url: 'adsdfsadfsdafa') }
  let!(:user_two) { User.create(name: 'Marie', email: 'Shelly@gmail', password: '111312', gravatar_url: 'adsddafa') }

  it 'Check if the friendship is invalid' do
    friendship_one = Friendship.create(user_id: nil, friend_id: nil, confirmed: false)
    expect(friendship_one).to be_invalid
  end

  it 'check if the friendship is valid' do
    friendship_one = Friendship.create(user_id: user_one.id, friend_id: user_two.id, confirmed: true)
    expect(friendship_one).to be_valid
  end
end

# rubocop: enable Layout/LineLength
