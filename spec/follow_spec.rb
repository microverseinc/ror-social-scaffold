require 'rails_helper'

RSpec.describe Follow, type: :model do
  subject do
    described_class.new(
      follower_id: ''
    )
  end

  describe 'Validations' do
    it 'is not valid without valid attributes' do
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:follower) }
    it { should belong_to(:leader) }
  end
end
