class PickTwoRace < Race
  private

  def selections
    votes.select(:selection).flat_map do |vote|
      vote.selection.split(',')
    end
  end
end
