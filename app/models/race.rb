class Race < ApplicationRecord
  belongs_to :election
  has_many :votes
  has_many :candidates

  def winner
    @winner ||= votes.winner_of self
  end

  def margin
    0.56
  end
end
