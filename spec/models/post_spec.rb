require 'rails_helper'

describe Post, type: :model do
  fixtures :users, :posts
  context 'Post is saved' do
    it 'validate content presence' do
      post = posts(:post1)
      post.user = users(:user1)
      expect(post.valid?).to eq true
    end

    it 'validate content length' do
      post = posts(:post1)
      post.user = users(:user1)
      expect(post.valid?).to eq true
    end
  end
  context 'Post is not saved' do
    it 'validate content presence' do
      post = posts(:post3)
      post.user = users(:user1)
      expect(post.valid?).to eq false
    end

    it 'validate content length' do
      post = posts(:post2)
      post.user = users(:user1)
      expect(post.valid?).to eq false
    end
  end

  describe 'associations for post' do
    it { should belong_to(:user) }
  end

  describe 'columns for post' do
    it { should have_db_column(:content) }
  end

  context ' scope' do
    it 'orders by most recent' do
      post = Post.new(content: 'Rspec is cool')
      post.user = users(:user1)
      post.save
      expect(Post.first).to eq posts(:post2)
      expect(Post.ordered_by_most_recent.first.content).to match(/Rspec is cool*/)
    end
  end
end
