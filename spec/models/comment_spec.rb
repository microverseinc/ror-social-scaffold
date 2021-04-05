require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
