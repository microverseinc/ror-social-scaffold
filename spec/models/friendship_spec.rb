require 'rails_helper'

RSpec.describe Friendship, type: :model do

  before do
    @sunday = FactoryBot.create(:user)
    @ahmed = FactoryBot.create(:user)
    @friendship = Friendship.create!(user_id: @sunday.id, friend_id: @ahmed.id)
  end

  context 'when friendship is created' do
    
    it 'should be valid' do      
      expect(@friendship).to be_valid
    end

    it 'changes friends count to 1' do
      expect(Friendship.count).to eq(1)
    end

    it 'confirmed should be false' do      
      expect(@friendship.reload.confirmed).to eq(false)
    end
  end

  context 'when a user accepts a friend request' do
    before do      
      @vincent = FactoryBot.create(:user)
      @friendship.confirmed = true
      @friendship.save 
      Friendship.create!(user_id: @vincent.id, friend_id: @sunday.id, confirmed: true)
    end

    it 'confirmed should be true' do  
      expect(@friendship.reload.confirmed).to eq(true)
    end

    it 'ahmed should be sunday\'s friend' do
      expect(@sunday.friend?(@ahmed)).to eq(true)
    end

    it 'ahmed should be sunday\'s friend' do
      expect(@sunday.friend?(@vincent)).to eq(true)
    end

    it 'ahmed should be sunday\'s friend' do
      expect(@vincent.friend?(@sunday)).to eq(true)
    end
  end
end
