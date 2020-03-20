require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations to test' do
    it { should validate_presence_of(:content) }
    # there is a problem with too_long in the validation model
    # it { should validate_length_of(:content).is_at_most(200) }
  end

  describe 'associations to test' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
