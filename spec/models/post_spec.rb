require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  context 'Validations' do
    it { should validate_presence_of(:content) }
  end
end
