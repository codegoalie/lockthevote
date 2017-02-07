# frozen_string_literal: true
class Api::RefreshTokensController < Api::ApplicationController
  skip_before_action :authenticate_by_token
  before_filter :authenticate_by_refresh

  def create
    @session = @user.sessions.create!(
      authentication_token: Devise.friendly_token,
      expires: 5.hours.from_now,
      refresh_token: Devise.friendly_token,
      refresh_expires: 3.days.from_now
    )

    render status: :created, template: 'api/sessions/create'
  end

  private

  def authenticate_by_refresh
    token_header = request.headers['Authorization'].presence
    return head(:unauthorized) unless token_header

    token = token_header.split(' ')[1]
    return head(:unauthorized) unless token

    auth_session = Session.where('refresh_expires > ?', Time.current)
                          .find_by(refresh_token: token)
    return head(:unauthorized) unless auth_session

    @user = auth_session.user
  end
end
