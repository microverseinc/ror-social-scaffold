require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  describe '#create' do
    let(:user) { create(:user) }
    let(:article) { create(:post, user: user) }

    before { sign_in(user) }

    it 'should create a comment if the request is valid' do
      post post_comments_path(article), params: { comment: { content: 'This is a comment' } }

      expect(article.comments.count).to eq(1)
    end

    it 'should not create a comment if request is invalid' do
      post post_comments_path(article), params: { comment: { content: '' } }

      expect(article.comments.count).to be_zero
    end
  end
end
