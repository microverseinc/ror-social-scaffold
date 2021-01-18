require 'rails_helper'

RSpec.describe Like, type: :model do
  fixtures :posts, :users
  subject { described_class.new(post: posts(:one), user: users(:one)) }

  describe 'validations' do
    it 'should not validate without post' do
      subject.post = nil
      expect(subject.valid?).to be(false)
    end

    it 'should not validate without user' do
      subject.user = nil
      expect(subject.valid?).to be(false)
    end

    it 'validates with valid data' do
      expect(subject.valid?).to be(true)
    end

    it 'saves new like object to database' do
      expect(subject.save).to be(true)
      expect(subject.id).to_not be(nil)
    end
  end

  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end
end
