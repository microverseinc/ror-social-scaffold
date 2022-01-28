require 'rails_helper'

RSpec.describe Post, type: 'model' do
  context 'association' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
  end
end
