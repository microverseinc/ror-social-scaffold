require 'rails_helper'

RSpec.describe User, type: :model do
  let(:params) { { name: 'Test User', email: 'testuser@example.com', password: 'password' } }
  subject { described_class.new(params) }

  describe 'validations' do
    it 'does not validate without name' do
      subject.name = nil
      expect(subject.valid?).to be(false)
    end

    it 'does not validate without email' do
      subject.email = nil
      expect(subject.valid?).to be(false)
    end

    it 'does not validate without password' do
      subject.password = nil
      expect(subject.valid?).to be(false)
    end

    it 'validates with valid data' do
      expect(subject.valid?).to be(true)
    end

    it 'saves new object to database' do
      expect(subject.save).to be(true)
      expect(subject.id).to be_an(Integer)
      expect(described_class.count).to eq(3)
    end
  end

  describe 'associations' do
    it { should have_many :posts }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:friendships).dependent(:destroy) }
    it { should have_many(:inverse_friendships).class_name(:Friendship).with_foreign_key(:friend_id) }
  end
end
