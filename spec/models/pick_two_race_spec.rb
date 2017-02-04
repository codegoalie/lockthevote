require 'rails_helper'

RSpec.describe PickTwoRace do
  describe '#winner' do
    it 'returns the candidate with the most selections' do
      race = FactoryGirl.create :pick_two_race
      winner = FactoryGirl.create :candidate, race: race
      other1 = FactoryGirl.create :candidate, race: race
      other2 = FactoryGirl.create :candidate, race: race

      3.times do
        FactoryGirl.create :vote,
                           race: race,
                           selection: [winner.id, other1.id].join(',')
      end
      3.times do
        FactoryGirl.create :vote,
                           race: race,
                           selection: [winner.id, other2.id].join(',')
      end
      2.times do
        FactoryGirl.create :vote,
                           race: race,
                           selection: [other1.id, other2.id].join(',')
      end

      expect(race.winner).to eq(winner)
    end
  end
end
