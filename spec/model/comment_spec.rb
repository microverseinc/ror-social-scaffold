require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  context 'Validations' do
    let(:user) { User.create(email: 'jteeetj@gmail.com', name: 'jeeeuoe', password: 'joiuyu7436run3jdws') }
    let(:post) { Post.create(user_id: user.id, content: 'life is beautiful') }
    let(:comment) { post.comments.build(user_id: user.id, content: 'osdhosd') }

    it 'valid for post with 1000 characters or less' do
      expect(comment).to be_valid
    end

    it 'invalid for post with more than 1000 characters' do
      comment.content = (0...202).map { ('a'..'z') }.join
      expect(comment).to_not be_valid
    end

    it { should validate_presence_of(:content) }
  end
end
