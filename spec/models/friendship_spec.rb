require 'rails_helper'

RSpec.describe Friendship, type: :model do

  context 'Associations' do
    
    it 'Belongs to User' do
      w = Friendship.reflect_on_association(:user)
      expect(w.macro).to eq(:belongs_to)
    end

    it ' Belongs to Friend' do
      w = Friendship.reflect_on_association(:friend)
      expect(w.macro).to eq(:belongs_to)
    end

   

  end
end