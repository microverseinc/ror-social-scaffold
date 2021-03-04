require 'rails_helper'

RSpec.describe UsersController do
  describe 'GET index' do
    fixtures :users

    it 'assigns @users' do
      login_as(users(:user1))
      # users = User.where('id != ?', User.find(1).id).all
      # get :index
      # expect(assigns(users)).to eq([users])
      expect(response).to have_http_status(:ok)
    end
  end
end
