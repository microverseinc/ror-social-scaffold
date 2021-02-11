require 'rails_helper'

RSpec.describe Friendship, type: :model do
  subject(:friendship) { build(:friendship) }

  describe 'associations' do
    it { is_expected.to belong_to(:requester).class_name('User') }

    it { is_expected.to belong_to(:addressee).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to define_enum_for(:status).with_values(accepted: 'accepted', pending: 'pending').backed_by_column_of_type(:string) } # rubocop:disable Layout/LineLength
  end
end
