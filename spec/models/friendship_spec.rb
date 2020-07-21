require_relative '../rails_helper'

RSpec.describe Friendship, type: :model do
  context 'testing associations' do
    it 'should have one user' do
      f = Friendship.reflect_on_association(:user)
      expect(f.macro).to eq(:belongs_to)
    end
    it 'should have one friend' do
      f = Friendship.reflect_on_association(:friend)
      expect(f.macro).to eq(:belongs_to)
    end
  end
end
