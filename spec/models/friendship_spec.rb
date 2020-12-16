require 'rails_helper'

RSpec.describe Friendship, type: :model do

  context 'Associations' do
    
    it 'Belong to User' do
      t = Friendship.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end

    it ' Belong to Friend' do
      t = Friendship.reflect_on_association(:friend)
      expect(t.macro).to eq(:belongs_to)
    end


  end
end