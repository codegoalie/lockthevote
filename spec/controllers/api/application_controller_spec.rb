# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::ApplicationController, type: :controller do
  controller do
    def index
      render status: :ok, json: { message: 'Hello, world!' }
    end
  end

  describe '#authenticate_by_token' do
    before do
      headers = { Authorization: "BEARER #{authentication_token}" }
      request.headers.merge!(headers)
      get :index
    end

    context 'with a current session' do
      let(:session) { FactoryGirl.create(:session) }
      let(:authentication_token) { session.authentication_token }

      it 'renders through to the controller' do
        expect(response).to have_http_status :ok
      end
    end

    context 'with an expired session' do
      let(:session) { FactoryGirl.create(:session, :expired) }
      let(:authentication_token) { session.authentication_token }

      it 'halts with unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'with no session' do
      let(:authentication_token) { '' }

      it 'halts with unauthorized' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
