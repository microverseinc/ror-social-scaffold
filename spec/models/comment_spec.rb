require 'rails_helper'

RSpec.describe 'Post' do
  context 'Creating new post' do
    let!(:user) { create(:random_user) }
    let!(:post) { create(:random_post) }
    let(:long_text) { 'X' * 201 }

    it 'shouldn\'t be able to comment a text longer than 200 char' do
      comment = Comment.new(user_id: 1, post_id: 1, content: long_text)
      comment.valid?
      expect(comment.errors.messages[:content]).to eql(['200 characters in comment is the maximum allowed.'])
    end
  end
end
