# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::RefreshTokensController do
  render_views

  describe '#create' do
    let(:parsed_response) { JSON.parse(response.body) }

    before do
      headers = { Authorization: "REFRESH #{refresh_token}" }
      request.headers.merge!(headers)
      get :create, format: :json
    end

    context 'with a current session' do
      let(:session) { FactoryGirl.create(:session) }
      let(:refresh_token) { session.refresh_token }

      it 'creates a session' do
        expect(response).to have_http_status :created
        expect(parsed_response['authentication_token']).not_to be_blank
        expect(parsed_response['expires']).not_to be_blank
        expect(parsed_response['refresh_token']).not_to be_blank
        expect(parsed_response['refresh_expires']).not_to be_blank
      end
    end

    context 'with an expired session' do
      let(:session) { FactoryGirl.create(:session, :expired_refresh) }
      let(:refresh_token) { session.refresh_token }

      it 'halts with unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'with no session' do
      let(:refresh_token) { '' }

      it 'halts with unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
