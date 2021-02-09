RSpec.describe Like do
  let(:test_user) { User.create(name: 'name of user', email: 'user@example.com', password: 'user123') }
  let(:test_post) { Post.create(content: 'This is content of the post', user_id: test_user.id) }
  let(:subject) do
    described_class.new(
      post_id: test_post.id,
      user_id: test_user.id
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end

  describe 'Associations', type: :model do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end
end
