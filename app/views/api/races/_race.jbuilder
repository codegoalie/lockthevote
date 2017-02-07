json.call(race, :id, :office, :description, :type)
json.candidates race.candidates, partial: 'api/candidates/candidate', as: :candidate
