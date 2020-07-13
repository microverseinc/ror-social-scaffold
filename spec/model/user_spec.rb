require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
  end

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:sent_requests).with_foreign_key(:sender_id).class_name('Friendship') }
    it { should have_many(:received_requests).with_foreign_key(:receiver_id).class_name('Friendship') }
  end
end
