require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Users connections' do
    before(:all) do
      @jhon = User.create(name: 'jhon', email: 'jhon@mail.com', password: '1234567')
      @ana = User.create(name: 'ana', email: 'ana@mail.com', password: '1234567')
    end

    it '#user_index' do
      sign_in @jhon
      get :index
      expect(response).to render_template('index')
    end

    it '#user_show' do
      sign_in @jhon
      post :show, params: { id: @ana.id }
      expect(response).to render_template('show')
    end

    it 'send_and_accept_friends' do
      sign_in @jhon
      get :add_friend, params: { id: @ana.id }
      expect(response).to redirect_to users_path
      expect(flash[:notice]).to match("Friends request has been sent")
      sign_out @jhon
      sign_in @ana
      get :accepts_friend, params: { id: @jhon.id }
      expect(response).to redirect_to users_path
      expect(flash[:notice]).to match("You have been accepted friendship")
    end

    it 'send_and_reject_friendship' do
      sign_in @jhon
      get :add_friend, params: { id: @ana.id }
      expect(flash[:notice]).to match("Friends request has been sent")
      expect(response).to redirect_to users_path
      sign_out @jhon
      sign_in @ana
      ids = Friendship.last.id
      delete :reject_friend, params: { id: ids }
      expect(response).to redirect_to users_path
      expect(flash[:notice]).to match("Friendship request rejected Successfully")
    end
  end
end
