json.call(race, :id, :office, :description, :type)
json.races race.candidates, partial: 'api/candidates/candidate', as: :candidate
