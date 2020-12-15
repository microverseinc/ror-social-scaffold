require 'rails_helper'

RSpec.describe "Friendships", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/friendships/new"
      expect(response).to have_http_status(:success)
    end
  end

end
