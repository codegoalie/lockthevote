class Vote < ApplicationRecord
  belongs_to :voter, class_name: 'User'
  belongs_to :race

  validate :selections_exist_as_candidates

  def best_selection
    selection
  end

  private

  def selection_ids
    selection.to_s.split(',')
  end

  def selections_exist_as_candidates
    selection_ids.each do |id|
      next if race.candidates.where(id: id).exists?
      errors.add(:selection,
                 I18n.t('errors.vote.selection.does_not_exist'))

      break
    end
  end
end
