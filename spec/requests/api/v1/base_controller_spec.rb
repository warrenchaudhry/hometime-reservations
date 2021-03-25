require "rails_helper"

RSpec.describe 'Base API authentication', type: :request do

  let(:headers) { { Authorization:  'Token sample-token' } }

  describe "#authenticate" do
    context "when correct authentication token is passed" do
      it 'returns http success' do
        get api_v1_root_url, params: {}, headers: headers
        expect(response).to have_http_status(200)
      end
    end

    context "when auth token is not passed" do
      before { get api_v1_root_url }
      it 'returns 401 http status' do
        expect(response).to have_http_status(401)
      end
    end
  end
end