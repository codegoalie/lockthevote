class PickTwoVote < Vote
  validate :exactly_two_selections, :for_a_pick_two_race

  private

  def exactly_two_selections
    return if selection_ids.size == 2
    errors.add(:selection,
               I18n.t('errors.pick_two_vote.selection.exactly_two'))
  end

  def for_a_pick_two_race
    return if race.is_a?(PickTwoRace)
    errors.add(:race,
               I18n.t('errors.pick_two_vote.race.not_a_pick_two'))
  end
end
