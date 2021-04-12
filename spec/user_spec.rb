require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      name: 'dave',
      email: 'test@test.com'
    )
  end

  describe 'Validations' do
    it 'is  invalid without valid attributes' do
      expect(subject).to_not be_valid
    end
  end
end
