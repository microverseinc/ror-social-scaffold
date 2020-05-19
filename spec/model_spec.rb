require 'rails_helper'
describe 'Friendhip testing' do
  before :each do
    a = User.new(name: 'gajksj', email: 'user@example.com', password: 'password1234')
    a.save
    b = User.new(name: 'gfdgsj', email: 'ali@example.com', password: 'password1234')
    b.save
    c = Friendship.new(user_id: 1, friend_id: 2, confirmed: false)
    c.save
  end
  it 'duplication check' do
    a = Friendship.new(user_id: 1, friend_id: 2, confirmed: false)
    a.save
    expect(Friendship.where(user_id: 1, friend_id: 2).count <= 1).to eq(true)
  end
end
