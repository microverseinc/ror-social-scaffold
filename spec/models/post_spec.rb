require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'with 2 or more comments' do
    it 'orders them in reverse chronologically' do
      post = Post.create!
      comment1 = post.comments.create!(body: 'first comment')
      comment2 = post.comments.create!(body: 'second comment')
      expect(post.reload.comments).to eq([comment2, comment1])
    end
  end
end
