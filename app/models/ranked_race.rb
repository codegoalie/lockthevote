class RankedRace < Race
  def winner
    if winning_selection[1] > (vote_count / 2)
      candidates.find(winning_selection[0])
    else
      false
    end
  end

  def vote_count
    @vote_count ||= votes.count
  end

  private

  def selections(_round = 0)
    votes.pluck(:selection).map do |selection|
      selection.split(',')[0]
    end
  end
end
