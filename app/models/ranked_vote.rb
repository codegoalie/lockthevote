class RankedVote < Vote
  def best_selection(without = [])
    selection.split(',').find do |pick|
      !(without.include? pick)
    end
  end
end
