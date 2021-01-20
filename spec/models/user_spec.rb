require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it ' ensures name not blank' do
      user = User.new(name: '').save
      expect(user).to eql(false)
    end
  end
  context 'creating and saving friendships' do
    let(:u1){ User.create(name: 'one', email: 'one@user.com', password: '1234567')}
    let(:u2){ User.create(name: 'two', email: 'two@user.com', password: '1234567')}
    it 'testing user friendship and inverse frienship' do
      u1.friendships.create(friend_id: u2.id)
      expect(u1.friendships).not_to  eql(u2.friendships)
    end
    it 'expects confirm friendship to make users friends' do
      u1.friendships.create(friend_id: u2.id)
      u2.confirm_friend(u1)
      expect(u1.friends.include?(u2)).to eql(true)
    end

  end
  
end
