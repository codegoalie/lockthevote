require 'rails_helper'

RSpec.describe Race do
  describe '#winner' do
    it 'returns the candidate with the most selections' do
      race = FactoryGirl.create :race
      winner = FactoryGirl.create :candidate, race: race
      loser = FactoryGirl.create :candidate, race: race

      3.times do
        race.record_vote(FactoryGirl.create(:user), winner)
      end
      2.times do
        race.record_vote(FactoryGirl.create(:user), loser)
      end

      expect(race.winner).to eq(winner)
    end
  end
end
