require 'rails_helper'

RSpec.describe "Clocks", type: :request do
  describe "GET /get_time" do
    it "returns http success" do
      get "/clock/get_time"
      expect(response).to have_http_status(:success)
    end
  end

end
