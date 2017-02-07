# frozen_string_literal: true
class Election < ApplicationRecord
  has_many :races

  def self.current
    now = Time.current
    where('starts_at < ? and ends_at > ?', now, now)
  end
end
