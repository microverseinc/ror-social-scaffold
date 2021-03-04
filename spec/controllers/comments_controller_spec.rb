require 'rails_helper'

describe 'CommentsController' do
  fixtures :users

  setup do
    sign_in(users(:user1))
  end

  describe 'Comment #create' do
    it 'creates a comment' do
      expect(response).to have_http_status(:ok)
    end
  end
end
