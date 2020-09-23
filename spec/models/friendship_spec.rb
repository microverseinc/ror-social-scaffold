require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'Association' do
    it 'Should belong to user' do
      u = Friendship.reflect_on_association(:user)
      expect(u.macro).to eq(:belongs_to)
    end

    it 'should belong to friend' do
      u = Friendship.reflect_on_association(:friend)
      expect(u.macro).to eq(:belongs_to)
    end
  end
end
