require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  it 'user cannot like a post more than once' do
    should validate_uniqueness_of(:user_id).scoped_to(:post_id)
  end
end
