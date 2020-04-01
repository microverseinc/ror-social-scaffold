require 'rails_helper'

RSpec.describe 'UserFlows', type: :request do
  describe 'GET /new_user_session' do
    it 'True!' do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
  end
end