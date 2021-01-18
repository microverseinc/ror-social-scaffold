require 'rails_helper'

RSpec.describe Comment, type: :model do
  fixtures :posts, :users
  subject { described_class.new(content: 'Test comment', post: posts(:one), user: users(:one)) }

  describe 'validations' do
    it 'should not validate without content' do
      subject.content = nil
      expect(subject.valid?).to be(false)
    end

    it 'should not validate without post' do
      subject.post = nil
      expect(subject.valid?).to be(false)
    end

    it { should validate_length_of(:content).is_at_most(200) }

    it 'should validate with valid data' do
      expect(subject.valid?).to be(true)
    end

    it 'saves new comment to database' do
      expect(subject.save).to be(true)
      expect(described_class.count).to be(1)
      expect(subject.id).not_to be(nil)
    end
  end

  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end
end
