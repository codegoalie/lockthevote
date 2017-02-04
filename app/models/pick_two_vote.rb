class PickTwoVote < Vote
  validate :exactly_two_selections, :selections_exist_as_candidates,
           :for_a_pick_two_race

  private

  def selection_ids
    selection.to_s.split(',')
  end

  def exactly_two_selections
    return if selection_ids.size == 2
    errors.add(:selection,
               I18n.t('errors.pick_two_vote.selection.exactly_two'))
  end

  def selections_exist_as_candidates
    selection_ids.each do |id|
      next if race.candidates.where(id: id).exists?
      errors.add(:selection,
                 I18n.t('errors.pick_two_vote.selection.does_not_exist'))

      break
    end
  end

  def for_a_pick_two_race
    return if race.is_a?(PickTwoRace)
    errors.add(:race,
               I18n.t('errors.pick_two_vote.race.not_a_pick_two'))
  end
end
