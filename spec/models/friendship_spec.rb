require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { User.create(name: 'Kotoku', email: 'kotoku@gmail.com', password: 'sports') }
  let(:friend) { User.create(name: 'Tamara', email: 'tam@gmail.com', password: 'chocolate') }
  let(:friendship) { Friendship.create(user_id: user.id, friend_id: friend.id) }

  describe 'Validations' do
    it 'should validate valid relationship' do
      expect(friendship).to be_valid
    end
  end

  describe 'Associations' do
    it 'should belong to user' do
      a = Friendship.reflect_on_association(:user)
      expect(a.macro).to eql: belongs_to
    end
    it 'should belong to friend' do
      a = Friendship.reflect_on_association(:friend)
      expect(a.macro).to eql: belongs_to
    end
  end
end
