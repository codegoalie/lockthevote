# frozen_string_literal: true
FactoryGirl.define do
  factory :session do
    user
    authentication_token Devise.friendly_token
    expires 5.hours.from_now
    refresh_token Devise.friendly_token
    refresh_expires 3.days.from_now

    trait :expired do
      expires 10.minutes.ago
    end

    trait :expired_refresh do
      expires 10.minutes.ago
      refresh_expires 10.minutes.ago
    end
  end
end
