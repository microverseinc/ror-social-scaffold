require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context "Friendship" do
    before(:each) do
    User.create(id: 1, email: 'user@email.com', password: 'password', name: 'user')
    User.create(id: 2, email: 'user2@email.com', password: 'password', name: 'user2')
  
  end
  let(:friend) { Friendship.create(user_id: 1, friend_id: 2, confirmed: false)}
  it { expect(friend).to be_valid } 
 end
end

