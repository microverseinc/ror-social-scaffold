require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'Validations' do
    it { expect(subject).to validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end

  context 'Associations' do
    it { expect(subject).to belong_to(:user) }

    it { expect(subject).to belong_to(:post) }
  end
end
