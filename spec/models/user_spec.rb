require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Valiations' do
    it 'expect user to be valid' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
  end

  describe 'Asociation' do
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships).class_name('Friendship').with_foreign_key('friend_id') }
    it { should have_many(:posts) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end
end
