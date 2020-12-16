require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(20) }
  end

  describe 'association' do
    it { should have_many(:posts) }

    it { should have_many(:comments).dependent(:destroy) }

    it { should have_many(:likes).dependent(:destroy) }

    it { should have_many(:friendships).with_foreign_key('requesting_user_id') }

    it { should have_many(:friendship_requests).with_foreign_key('receiving_user_id').class_name('Friendship') }

  end
end