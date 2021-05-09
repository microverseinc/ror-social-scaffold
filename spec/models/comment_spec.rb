require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:content) }
    it do
      should validate_length_of(:content)
        .is_at_most(200)
        .with_long_message('200 characters in comment is the maximum allowed.')
    end
  end

  context 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
