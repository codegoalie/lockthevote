# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::SessionsController do
  render_views

  describe '#create' do
    let(:parsed_response) { JSON.parse(response.body) }

    before do
      post :create, params: { email: email, password: password }, format: :json
    end

    context 'with a valid email and password' do
      let(:user) { FactoryGirl.create(:user) }
      let(:email) { user.email }
      let(:password) { user.password }

      it 'creates a session' do
        expect(response).to have_http_status :created
        expect(parsed_response['authentication_token']).not_to be_blank
        expect(parsed_response['expires']).not_to be_blank
        expect(parsed_response['refresh_token']).not_to be_blank
        expect(parsed_response['refresh_expires']).not_to be_blank
      end
    end

    context 'with invalid credentials' do
      let(:email) { '' }
      let(:password) { '' }

      it 'is unauthenticated' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
