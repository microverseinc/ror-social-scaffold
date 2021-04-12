require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject do
    described_class.new(
      content: 'test'
    )
  end

  describe 'Validations' do
    it 'is  invalid without valid attributes' do
      expect(subject).to_not be_valid
    end
  end
end
