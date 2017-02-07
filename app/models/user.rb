# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :developer]

  has_many :sessions

  def self.from_omniauth(access_token)
    data = access_token.info
    new_email = data['email']
    user = User.where(email: new_email).first

    unless user
      user = User.create(
        email: new_email,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end
end
