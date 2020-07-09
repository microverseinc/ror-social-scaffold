require 'rails_helper'

RSpec.describe 'Post' do
  context 'Creating new post' do
    let!(:user) { create(:random_user) }
    let(:long_text) { 'X' * 1001 }

    it 'should create a post' do
      post = Post.create(content: 'text', user_id: 1)
      expect(post.content).to eql('text')
    end

    it 'should refuse the creation of a post longer than 1000 char' do
      post = Post.new(content: long_text, user_id: 1)
      post.valid?
      expect(post.errors.messages[:content]).to eql(['1000 characters in post is the maximum allowed.'])
    end

    it 'should refuse the creation of a post with a user that doesn\'t exist' do
      post = build(:random_post)
      post.user_id = 666
      post.valid?
      expect(post.errors.messages[:user]).to eql(['must exist'])
    end
  end

  context 'Searching for a post' do
    let!(:user) { create(:random_user) }
    let!(:posts_list) { create_list(:random_post, 20) }

    it 'should be able to list the posts by most recent' do
      x = Post.all.ordered_by_most_recent
      expect(x.first[:id] - x.last[:id] + 1).to eql(20)
    end
  end
end
