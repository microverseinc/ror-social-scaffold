require 'rails_helper'

RSpec.describe Post, type: :model do
  fixtures :users
  subject { described_class.new(content: 'Test post', user: users(:one)) }

  describe 'validations' do
    it { validate_presence_of(:content) }

    it 'does not validate without content' do
      subject.content = nil
      expect(subject.valid?).to be(false)
    end

    it 'does not validate without a user' do
      subject.user = nil
      expect(subject.valid?).to be(false)
    end

    it 'validates with valid data' do
      expect(subject.valid?).to be(true)
    end

    it 'saves new post object to database' do
      expect(subject.save).to be(true)
      expect(described_class.count).to eq(2)
      expect(subject.id).to be_an(Integer)
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end
end
