require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  describe '#create' do
    it 'should create the like object' do
      user = create(:user)
      article = create(:post, user: user)
      sign_in(user)
      post post_likes_path(article), params: nil

      expect(article.likes.count).to eq(1)
    end
  end

  describe '#destroy' do
    it 'should destroy the like object' do
      user = create(:user)
      article = create(:post, user: user)
      like = create(:like, post: article, user: user)
      sign_in(user)
      delete post_like_path(article, like)

      expect(article.likes.count).to be_zero
    end
  end
end
