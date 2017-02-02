class Vote < ApplicationRecord
  belongs_to :voter, class: 'User'
  belongs_to :race
  belongs_to :selection, class: 'Candidate'
end
