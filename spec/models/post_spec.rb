require 'rails_helper.rb'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should belong_to(:user) }
  end
end
