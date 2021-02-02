require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:content) }

    it { should validate_length_of(:content).is_at_most(1000).with_message('Only 1000 characters per post ') }
  end

  describe 'association' do
    it { should belong_to(:user) }

    it { should have_many(:comments).dependent(:destroy) }

    it { should have_many(:likes).dependent(:destroy) }
  end
end
