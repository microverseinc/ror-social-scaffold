require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) do
    User.create(
      name: 'john',
      email: 'john@gmail.com',
      password: 'password'
    )
  end

  describe 'Create actions' do
    it 'creates a comment when content present' do
      sign_in(user, scope: :user)
      user_post = Post.create(content: 'Post to comment!', user_id: user.id)
      post :create, params: { post_id: user_post.id, comment: { content: 'Comment to post!' } }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice].present?).to be(true)
    end

    it "doesn't create a comment when content is not present" do
      sign_in(user, scope: :user)
      user_post = Post.create(content: 'Post to comment!', user_id: user.id)
      post :create, params: { post_id: user_post.id, comment: { content: '' } }
      expect(response).to redirect_to(posts_path)
      expect(flash[:alert].present?).to be(true)
    end
  end
end
