require 'rails_helper'

describe LikesController do
  fixtures :users

  setup do
    sign_in(users(:user2))
  end

  describe 'Like #create' do
    it 'renders an ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
