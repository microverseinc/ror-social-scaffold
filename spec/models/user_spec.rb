require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:posts) }

    it 'User should have many friends' do
      should have_many(:friendships)
    end
    it 'User can have many posts' do
      should have_many(:posts)
    end
    it 'User can have many comments' do
      should have_many(:comments)
    end
    it 'User can have many likes' do
      should have_many(:likes)
    end
  end
end
