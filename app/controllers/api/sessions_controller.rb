# frozen_string_literal: true
class Api::SessionsController < ApplicationController
  before_action :authenticate_with_email_and_password

  def create
    @session = @user.sessions.create!(
      authentication_token: Devise.friendly_token,
      expires: 5.hours.from_now,
      refresh_token: Devise.friendly_token,
      refresh_expires: 3.days.from_now
    )

    render status: :created
  end

  private

  def authenticate_with_email_and_password
    email = params[:email].presence
    @user = User.find_by(email: email)

    head :unauthorized unless @user&.valid_password?(params[:password])
  end
end
