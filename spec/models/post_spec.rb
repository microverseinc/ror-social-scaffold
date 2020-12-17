require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Associations' do
    it 'Belongs to User' do
      w = Like.reflect_on_association(:user)
      expect(w.macro).to eql(:belongs_to)
    end

    it 'Has many likes' do
      have_many(:likes)
    end

    it 'Has many comments' do
      have_many(:comments)
    end
  end

  context 'Post model validation' do
    post = Post.new(content: 'wilmer')
    it 'Post model content' do
      expect(post.content).to eql('wilmer')
    end

    it 'Post must not be empty' do
      expect(post.content).not_to be_empty
    end
  end
end
