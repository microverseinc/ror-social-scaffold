require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'associations' do
    it { should have_many(:comments) }
  end

  describe 'associations' do
    it { should have_many(:likes) }
  end
end
