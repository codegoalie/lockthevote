# frozen_string_literal: true
class Api::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_by_token

  private

  attr_reader :current_user

  def authenticate_by_token
    token_header = request.headers['Authorization'].presence
    return head(:unauthorized) unless token_header

    token = token_header.split(' ')[1]
    return head(:unauthorized) unless token

    auth_session = Session.where('expires > ?', Time.current)
                          .find_by(authentication_token: token)
    return head(:unauthorized) unless auth_session

    @current_user = auth_session.user
  end
end
