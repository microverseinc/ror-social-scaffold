require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { FactoryBot.build(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:sent_requests) }
    it { should have_many(:sent_friends) }
    it { should have_many(:incoming_requests) }
    it { should have_many(:incoming_friends) }
    it { should have_many(:confirmed_friendships) }
    it { should have_many(:confirmed_friends) }
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end
