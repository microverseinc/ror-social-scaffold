require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
  end

  context 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:posts) }
    it { should have_many(:likes).dependent(:destroy) }

    it { should have_many(:friendships).dependent(:destroy) }
  end
end
