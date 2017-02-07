json.call(election, :name, :starts_at, :ends_at)
json.races election.races, partial: 'api/races/race', as: :race
