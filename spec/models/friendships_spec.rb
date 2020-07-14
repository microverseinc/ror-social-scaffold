require 'rails_helper'

RSpec.describe 'Friendship' do
  context 'user and friend have friendship' do
    let!(:user) { create(:random_user) }
    let!(:friend) { create(:random_friend) }

    it 'should raise an exception if a user tries to befriend another twice' do
      original_friendship = create(:confirmed_friendship)
      duplicated_friendship = build(:confirmed_friendship)
      expect { duplicated_friendship.save }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
