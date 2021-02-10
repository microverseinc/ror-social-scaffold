require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe '#create' do
    let(:user) { create(:user) }

    before { sign_in(user) }

    it 'creates a new post' do
      post posts_path, params: { post: { content: 'hello world' } }

      expect(user.posts.count).to eq(1)
    end

    it 'does not create a post if request is invalid' do
      post posts_path, params: { post: { content: '' } }

      expect(user.posts.count).to be_zero
    end
  end
end
