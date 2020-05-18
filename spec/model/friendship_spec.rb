require 'rails_helper'

RSpec.describe Friendship, type: :model do

    context 'Association' do
      it 'should belong to user' do
        t = Friendship.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
      it 'should belong to friend' do
        t = Friendship.reflect_on_association(:friend)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end