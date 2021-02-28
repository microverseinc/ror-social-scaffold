require_relative '../rails_helper'

RSpec.describe Comment do
  context 'validations' do
    it { should validate_presence_of(:content) }
    it {
      should validate_length_of(:content)
        .is_at_most(200)
        .with_message('200 characters in comment is the maximum allowed.')
    }
  end

  context 'assosciations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end
end
