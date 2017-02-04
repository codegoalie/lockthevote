require 'rails_helper'

RSpec.describe Race do
  describe '#winner' do
    it 'returns the candidate with the most selections' do
      race = FactoryGirl.create :race
      winner = FactoryGirl.create :candidate, race: race
      loser = FactoryGirl.create :candidate, race: race

      3.times do
        FactoryGirl.create :vote, race: race, selection: winner.id
      end
      2.times do
        FactoryGirl.create :vote, race: race, selection: loser.id
      end

      expect(race.winner).to eq(winner)
    end
  end
end
