module RaceHelper
  def race_winner_class(race, candidate)
    if race.winner == candidate
      'bold'
    else
      ''
    end
  end
end
