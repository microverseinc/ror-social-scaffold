require 'rails_helper'

describe PostsController, type: :controller do
  fixtures :users

  setup do
    sign_in(users(:user1))
  end

  context 'GET #index' do
    it 'renders a success response' do
      post = Post.new(content: 'Rspec Controller Test')
      post.user = users(:user1)
      post.save
      get :index
      expect(response).to be_successful
    end
  end
end
