require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it {
      # rubocop:disable Layout/LineLength
      should validate_length_of(:content).is_at_most(1000).with_message('1000 characters in post is the maximum allowed.')
      # rubocop:enable Layout/LineLength
    }
  end
end
