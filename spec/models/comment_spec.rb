require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it {
      # rubocop:disable Layout/LineLength
      should validate_length_of(:content).is_at_most(200).with_message('200 characters in comment is the maximum allowed.')
      # rubocop:enable Layout/LineLength
    }
  end
end
