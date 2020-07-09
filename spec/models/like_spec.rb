RSpec.describe 'Like' do
  context 'Give a like' do
    let!(:user) { create(:random_user) }
    let!(:post) { create(:random_post) }

    it 'should give a like' do
      like = Like.create(post_id: post.id, user_id: user.id)
      expect(Like.last).to eql(like)
    end
  end
end
