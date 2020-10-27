require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    subject { FactoryBot.build(:friendship) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:friend_id) }
    it { should validate_uniqueness_of(:friend_id).scoped_to(:user_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end
