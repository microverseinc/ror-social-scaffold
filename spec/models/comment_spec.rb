require 'rails_helper'

RSpec.describe 'Comment' do
  context 'Creating new comment' do
    let!(:user) { create(:random_user) }
    let!(:post) { create(:random_post) }
    let(:long_text) { 'X' * 201 }

    it 'should be able to create a comment' do
      comment = Comment.create(user_id: 1, post_id: 1, content: 'text')
      expect(comment.content).to eql('text')
    end

    it 'shouldn\'t be able to comment a text longer than 200 char' do
      comment = Comment.new(user_id: 1, post_id: 1, content: long_text)
      comment.valid?
      expect(comment.errors.messages[:content]).to eql(['200 characters in comment is the maximum allowed.'])
    end
  end
end
