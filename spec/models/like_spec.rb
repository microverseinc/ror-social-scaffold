RSpec.describe 'Like' do
  context 'Give a like' do
    let!(:user) { create(:random_user) }
    let!(:post) { create(:random_post) }

    it 'should give a like' do
      like = Like.create(post_id: post.id, user_id: user.id)
      expect(Like.last).to eql(like)
    end

    it 'shouldn\'t give a like' do
      Like.create(post_id: post.id, user_id: user.id)
      like = Like.new(post_id: post.id, user_id: user.id)
      expect(like.valid?).to eql(false)
    end
  end
end
