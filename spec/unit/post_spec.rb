require 'rails_helper'
RSpec.describe Post, type: :model do
  context 'validation' do
    it { should validate_presence_of(:content) }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end
end
