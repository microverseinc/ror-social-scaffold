require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before do
    @sunday = FactoryBot.create(:user)
    @ahmed = FactoryBot.create(:user)
    @friendship = Friendship.create!(user_id: @sunday.id, friend_id: @ahmed.id)
  end

  context 'when created' do
    it 'should be valid' do
      expect(@friendship).to be_valid
    end

    it 'changes friends count to 1' do
      expect(Friendship.count).to eq(1)
    end

    it 'confirmed should be false' do
      expect(@friendship.reload.confirmed).to eq(false)
    end

    it 'confirmed should be true' do
      @friendship.confirmed = true
      @friendship.save
      expect(@friendship.reload.confirmed).to eq(true)
    end
  end
end
