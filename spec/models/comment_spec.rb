require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:content) }

    it { should validate_length_of(:content).is_at_most(200).with_message('200 characters in comment is the maximum allowed.') }
  end

  describe 'association' do
    it { should belong_to(:user) }

    it { should belong_to(:post) }
  end
end