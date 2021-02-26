require 'rails_helper'

RSpec.describe Friendship, type: :model do

  unconfirmed_friendship_1 = Friendship.new(user_id: 34, friend_id: 45)
  it 'status is false' do
    expect(unconfirmed_friendship_1.status).to be false
  end
  
  unconfirmed_friendship_2 = Friendship.new(user_id: 43, friend_id: 50)
  unconfirmed_friendship_2.update({ status: true })
  it 'status is true' do
    expect(unconfirmed_friendship_2.status).to be true
  end
  

end
