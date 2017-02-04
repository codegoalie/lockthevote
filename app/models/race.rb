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
    selections.each_with_object(Hash.new(0)) do |selection, counts|
      counts[selection] += 1
    end
  end

  def selections
    votes.pluck(:selection)
  end
end
