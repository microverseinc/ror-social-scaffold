require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations to test' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
  end
  describe 'associations to test' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:oposite_friendships) }
  end
end
