RSpec.describe Post do
  let(:user) { User.create(name: 'elisha', email: 'elisha@gmail.com', encrypted_password: 'elishapassword') }

  context 'A post is created by a user' do
    it 'returns false when post does not have user_id' do
      post = Post.new

      post.content = 'What a nice party'
      expect(post.valid?).to be false
    end
    it 'returns true when post has an assosciated user or user_id' do
      post = Post.new

      post.user = user
      post.content = 'Hey the party'

      expect(post.valid?).to be true
    end
  end
  context 'validates presence of required fields' do
    it 'returns false when post content is not present' do
      post = Post.new
      post.user_id = user.id

      expect(post.valid?).to be false
    end
    it 'returns true when post content is present' do
      post = Post.new
      post.user = user
      post.content = 'jsfh asfjl'
      expect(post.valid?).to be true
    end
  end
end
