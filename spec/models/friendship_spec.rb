RSpec.describe Friendship, type: :model do
  context 'Association' do
    it { expect(subject).to belong_to(:user) }
  end
end
