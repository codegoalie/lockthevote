class Vote < ApplicationRecord
  belongs_to :voter, class_name: 'User'
  belongs_to :race
  belongs_to :selection, class_name: 'Candidate'

  def self.winner_of(race)
    where(race: race).select(:selection_id)
                     .group(:selection_id)
                     .order('count(*)')
                     .first.try(:selection)
  end
end
