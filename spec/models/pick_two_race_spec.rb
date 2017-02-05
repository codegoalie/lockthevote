require 'rails_helper'

RSpec.describe PickTwoRace do
  describe '#winner' do
    it 'returns the candidate with the most selections' do
      race = FactoryGirl.create :pick_two_race
      winner = FactoryGirl.create :candidate, race: race
      other1 = FactoryGirl.create :candidate, race: race
      other2 = FactoryGirl.create :candidate, race: race

      3.times do
        race.record_vote(FactoryGirl.create(:user), [winner, other1])
      end
      3.times do
        race.record_vote(FactoryGirl.create(:user), [winner, other2])
      end
      2.times do
        race.record_vote(FactoryGirl.create(:user), [other1, other2])
      end

      expect(race.winner).to eq(winner)
    end
  end
end
