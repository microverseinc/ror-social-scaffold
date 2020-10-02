require 'rails_helper'

RSpec.describe Comment, type: :model do
  before { @comment = FactoryGirl.build(:comment) }

  context 'Content should be present' do
    it { is_expected.to validate_presence_of(:content) }
  end

  context 'It should belong to' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
