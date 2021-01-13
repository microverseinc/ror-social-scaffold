require 'rails_helper'

RSpec.describe Friendship, type: :model do
  fixtures :users
  subject { described_class.new(user: users(:one), friend: users(:two)) }

  describe 'validations' do
    it 'does not validate without user_id' do
      subject.user_id = nil
      expect(subject.valid?).to be(false)
    end

    it 'does not validate without friend_id' do
      subject.friend_id = nil
      expect(subject.valid?).to be(false)
    end

    it 'validates with valid data' do
      expect(subject.valid?).to be(true)
    end

    it 'saves new object to database' do
      expect(subject.save).to be(true)
      expect(subject.id).to be_truthy
      expect(described_class.count).to eq(1)
    end
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should belong_to(:friend).class_name('User') }
  end
end
