require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_length_of(:name).is_at_most(20) }
  end
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:friendships) }
    it { should have_many(:friends) }
    it { should have_many(:pending_friends) }
    it { should have_many(:friend_requests) }
  end
end
