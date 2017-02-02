class Race < ApplicationRecord
  belongs_to :election
  has_many :votes
  has_many :candidates
end
