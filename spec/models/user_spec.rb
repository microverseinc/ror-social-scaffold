require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it ' ensures name not blank' do
      user = User.new(name: '').save
      expect(user).to eql(false)
    end
  end
  context 'creating and saving friendships' do
    it ' ensures name not blank' do
      u1 = User.create(name: 'one', email: 'one@user.com', password: '1234567')
      u2 = User.create(name: 'two', email: 'two@user.com', password: '1234567')
      u1.friendships.create(friend_id: u2.id)
      expect(u1.friendships).not_to  eql(u2.friendships)
    end
  end
  
end
