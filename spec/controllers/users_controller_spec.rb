require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
  end
  describe 'GET #index' do
    it 'gets all the users and render index page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'Renders user show page' do
      get :show, params: { id: @user.id }
      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response).to have_http_status(200)
    end
    context 'If user does not exis' do
      it 'is not a success' do
        begin
          get :show, params: { id: -1 }
        rescue StandardError
          ActiveRecord::RecordNotFound
        end
        expect(response).not_to render_template(:show)
      end
    end
  end
end
