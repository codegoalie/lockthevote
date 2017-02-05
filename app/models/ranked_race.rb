class RankedRace < Race
  def winner
    candidates.count.times do
      if current_winner_has_majority?
        return candidates.find(winning_selection[0])
      end

      eliminate_current_loser
      clear_intermediate_results
    end

    false
  end

  def vote_count
    @vote_count ||= votes.count
  end

  private

  def losing_selections
    @losing_selections ||= []
  end

  def selections
    @selections ||= votes.map { |v| v.best_selection(losing_selections) }
  end

  def winning_selection
    @winning_selection ||= results.max_by do |_selection, count|
      count
    end
  end

  def results
    @results ||= selections.each_with_object(Hash.new(0)) do |selection, counts|
      counts[selection] += 1
    end
  end

  def current_winner_has_majority?
    winning_selection[1] > (vote_count / 2)
  end

  def eliminate_current_loser
    losing_selections << results.min_by do |_selection, count|
      count
    end[0]
  end

  def clear_intermediate_results
    @selections = nil
    @winning_selection = nil
    @results = nil
  end
end
