require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) { User.create(name: 'test', email: 'email@email.com', password: 'abc123') }
  let(:friend1) { user1.frienships.create(friend_id: 2) }

  context 'check associations' do
    it 'retrieve all user friends' do
      user1
      friend1
      expect(Friendship.first.user_id).not_to be_nil
    end
  end

  # context 'check associations' do
  #   it 'retrieve all user friends' do
  #   end
  # end

  # context 'check associations' do
  #   it 'retrieve received invitations' do
  #   end
  # end
end
