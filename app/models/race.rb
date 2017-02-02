class Race < ApplicationRecord
  belongs_to :election
  has_many :votes
end
