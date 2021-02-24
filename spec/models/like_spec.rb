require 'rails_helper'

RSpec.describe Like, type: :model do
  subject(:like) { build(:like) }

  describe 'associations' do
    it { is_expected.to belong_to(:post) }

    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end
end