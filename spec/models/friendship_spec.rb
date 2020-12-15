require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'Association Test' do
    it 'belongs to users' do
      expect(Friendship.reflect_on_association(:user).macro).to be :belongs_to
    end

    it 'belongs to friend' do
      expect(Friendship.reflect_on_association(:friend).macro).to be :belongs_to
    end
  end
end
