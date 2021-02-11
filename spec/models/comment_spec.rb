require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { build(:comment) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to belong_to(:post) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }

    it { is_expected.to validate_length_of(:content).is_at_most(200).with_message('200 characters in comment is the maximum allowed.') } # rubocop:disable Layout/LineLength
  end
end
