require 'rails_helper'

RSpec.describe 'Friendship' do
  describe 'associations' do
    it 'should belong to a user' do
      friendship = Friendship.reflect_on_association(:user)
      expect(friendship.macro).to eql(:belongs_to)
    end
    it 'should belong to a user' do
      friendship = Friendship.reflect_on_association(:friend)
      expect(friendship.macro).to eql(:belongs_to)
    end
  end
end
