require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'validations' do
    it do
      expect(Like.new(post_id: 1))
        .to validate_uniqueness_of(:user_id)
        .scoped_to(:post_id)
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
