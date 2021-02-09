RSpec.describe Like do
  let(:user) { User.create(name: 'elisha', email: 'elisha@gmail.com', encrypted_password: 'elishapassword') }
  let(:post) { Post.create(content: 'This is content of the post', user_id: user.id) }
  let(:subject) do
    described_class.new(
      post: post,
      user: user
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end
end
