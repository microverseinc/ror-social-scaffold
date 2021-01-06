require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Associations' do
    it 'Have many Posts' do
      have_many(:posts)
    end
    it 'Have many Friends' do
      have_many(:friendships)
    end
    it 'Have many comments' do
      have_many(:comments)
    end
    it 'Have many Likes' do
      have_many(:likes)
    end
  end
end
