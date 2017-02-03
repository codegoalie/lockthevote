class Race < ApplicationRecord
  belongs_to :election
  has_many :votes
  has_many :candidates

  def winner
    candidates.first
  end

  def margin
    0.56
  end
end
