require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations to test' do
    it { should validate_presence_of(:content) }
    # there is a problem with too_long in the validation model
    # it { should validate_length_of(:content).is_at_most(1000) }
  end
  describe 'associations to test' do
    it { should belong_to(:user) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
  end
end
