class Race < ApplicationRecord
  belongs_to :election
  has_many :votes
  has_many :candidates

  def winner
    counts = results
    winning_selection = counts.max_by do |_selection, count|
      count
    end

    candidates.find(winning_selection[0])
  end

  private

  def results
    counts = Hash.new(0)
    votes.each do |vote|
      counts[vote.selection] += 1
    end
    counts
  end
end
