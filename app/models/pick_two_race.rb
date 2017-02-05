class PickTwoRace < Race
  def record_vote(user, selections)
    votes.create(type: 'PickTwoVote',
                 voter: user,
                 selection: selections.map(&:id).join(','))
  end

  private

  def selections
    votes.select(:selection).flat_map do |vote|
      vote.selection.split(',')
    end
  end
end
