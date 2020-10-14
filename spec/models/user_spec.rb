# rubocop: disable Layout/LineLength

require 'rails_helper'

RSpec.describe User, type: :model do
  User.delete_all
  Friendship.delete_all
  let!(:pedro) { User.create(name: 'heroku', email: 'heroku@heroku', password: '123456', gravatar_url: 'cualquiercosa') }
  let!(:tomas) { User.create(name: 'lulu', email: 'lulu@lulu', password: '654321', gravatar_url: 'cualquierotracosa') }
  let!(:lucas) { User.create(name: 'hero', email: 'hero@hero', password: '123456', gravatar_url: 'cualquierotracosaagain') }
  let!(:friend_real) { Friendship.create(user_id: 1, friend_id: 2, confirmed: true) }
  let!(:friend_real2) { Friendship.create(user_id: 2, friend_id: 1, confirmed: false) }
  let!(:friend_real3) { Friendship.create(user_id: 3, friend_id: 1, confirmed: false) }

  it 'Checks if the user has friends' do
    expect(pedro.friends).not_to be_nil
  end

  it 'Checks for the instance where the users has no friends.' do
    expect(tomas.friends).to be_empty
  end

  it 'Checks when the user has no pending friendships' do
    expect(tomas.pending_friends).not_to be_empty
  end

  it 'Checks for the to have user pending friends' do
    expect(pedro.pending_friends).to be_empty
  end

  it 'Checks for the pending request friend request sent by the user' do
    expect(pedro.friend_requests).not_to be_empty
  end

  it 'Checks if users are not friends' do
    expect(tomas.friend?(pedro)).to be false
  end

  it 'Checks if users are friends' do
    expect(pedro.friend?(tomas)).to be true
  end
end

# rubocop: enable Layout/LineLength
