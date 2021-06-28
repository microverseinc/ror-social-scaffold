require 'rails_helper'

RSpec.describe "Frienships", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/frienships/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/frienships/create"
      expect(response).to have_http_status(:success)
    end
  end

end
