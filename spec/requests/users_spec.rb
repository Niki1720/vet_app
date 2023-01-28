require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it "returns a success response" do
      get '/api/v1/users'

      expect(response).to have_http_status(:ok)
    end
  end
end
