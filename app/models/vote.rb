class Vote < ApplicationRecord
  belongs_to :voter, class_name: 'User'
  belongs_to :race
end
