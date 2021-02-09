describe Friendship, type: :model do
  it 'is valid with valid attributes' do
    expect(Friendship.new).to be_valid
  end

  context 'validations' do
    before { create(:friendship) }

    context 'presence' do
      it { should validate_presence_of :user }
    end

    context 'presence' do
      it { should validate_presence_of :friend }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of :userid_friendid }
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:friend) }
  end
end
