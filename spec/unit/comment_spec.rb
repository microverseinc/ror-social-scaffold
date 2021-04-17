require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  context 'Validations' do
    it { should validate_presence_of(:content) }
  end
end
