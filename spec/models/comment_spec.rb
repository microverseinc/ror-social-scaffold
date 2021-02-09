RSpec.describe Comment do
  let(:user) { User.create(id: 1, name: 'name of user', email: 'user@example.com', password: 'user123') }
  let(:post) { Post.create(content: 'This is content of the post', user_id: user.id) }
  let(:subject) do
    described_class.new(
      post_id: post.id,
      user_id: user.id,
      content: 'This is a the comment of the post'
    )
  end

  describe 'validations' do
    it 'valiates presence of content' do
      expect(subject).to be_valid
    end

    it 'The content of the comment length < 200' do
      subject.content = 't' * 205
      expect(subject).not_to be_valid
    end

    it 'The content of the comment length < 200' do
      subject.content = 't' * 100
      expect(subject).to be_valid
    end

    describe 'Associations', type: :model do
      it 'returns the post which the comment belongs to' do
        expect(subject.post).to eql(post)
      end
      it 'returns the user which the comment belongs to' do
        expect(subject.post.user).to eql(user)
      end
    end
  end
end
