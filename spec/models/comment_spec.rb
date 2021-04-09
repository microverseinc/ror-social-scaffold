require 'rails_helper'
# rubocop:disable Layout/LineLength
RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it {
      should validate_length_of(:content).is_at_most(200).with_long_message('200 characters in comment is the maximum allowed.')
    }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
# rubocop:enable Layout/LineLength
