require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:requested_friendships) }
    it { should have_many(:received_friendships) }
  end

  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_length_of(:password).is_at_least(6) }
  end
end
