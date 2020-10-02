require 'rails_helper'

RSpec.describe Post, type: :model do
  before { @post = FactoryGirl.build(:post) }

  context 'Check presence on content in post' do
    it { is_expected.to validate_presence_of(:content) }
  end

  context 'should belong to user model' do
    it { should belong_to(:user) }
  end

  context 'has many comments and likes' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end
