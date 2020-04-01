require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'JohnDoe', email: 'johndoe@ymail.com', password: 'password') }
  let(:post) { Post.new(content: 'A simple post content', user_id: user.id) }
  let(:comment) { Comment.new(post_id: post.id, user_id: user.id, content: 'A simple comment!') }

  context 'It has post_id, user_id and content' do
    it 'has to have a post_id' do
      expect(comment.post_id).to eq(post.id)
    end
    it 'has to have a user_id' do
      expect(comment.user_id).to eq(user.id)
    end
    it 'has to have a content' do
      expect(comment.content).to eq('A simple comment!')
    end
  end

  context 'it has to return an error for missing fields' do
    it 'returns an error for missing post_id' do
      comment.post_id = nil
      expect(comment.save).to eq(false)
    end
    it 'returns an error for missing user_id' do
      comment.user_id = nil
      expect(comment.save).to eq(false)
    end
    it 'returns an error for missing content' do
      comment.content = nil
      expect(comment.save).to eq(false)
    end
  end
end
