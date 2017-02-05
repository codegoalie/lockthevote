require 'rails_helper'

RSpec.describe RankedRace do
  let(:race) { FactoryGirl.create :ranked_race }

  describe '#winner' do
    let(:winner) { FactoryGirl.create :candidate, race: race }
    let(:other1) { FactoryGirl.create :candidate, race: race }
    let(:other2) { FactoryGirl.create :candidate, race: race }
    let(:other3) { FactoryGirl.create :candidate, race: race }
    let(:other4) { FactoryGirl.create :candidate, race: race }
    let(:winner_first) do
      [winner, other1, other2, other3, other4]
    end
    let(:winner_second) do
      [other1, winner, other2, other3, other4]
    end
    let(:two_winner_one) do
      [other2, winner, other1, other3, other4]
    end
    let(:two_three_winner) do
      [other2, other3, winner, other1, other4]
    end

    context 'when a candidate gets > 50% of first coices' do
      before do
        2.times do
          race.record_vote(FactoryGirl.create(:user), winner_second)
        end
        3.times do
          race.record_vote(FactoryGirl.create(:user), winner_first)
        end
      end

      it 'is the candidate with the most firt choice picks' do
        expect(race.winner).to eq winner
      end
    end

    context 'when no candidate gets > 50% of the first choice' do
      before do
        3.times do
          race.record_vote(FactoryGirl.create(:user), winner_second)
        end
        3.times do
          race.record_vote(FactoryGirl.create(:user), winner_first)
        end
        race.record_vote(FactoryGirl.create(:user), two_winner_one)
      end

      it 'eliminates choices for the lowest candidate' do
        expect(race.winner).to eq winner
      end
    end

    context 'when no candidate gets > 50% of the vote with on candidate out' do
      before do
        3.times do
          race.record_vote(FactoryGirl.create(:user), winner_second)
        end
        race.record_vote(FactoryGirl.create(:user), two_three_winner)
        3.times do
          race.record_vote(FactoryGirl.create(:user), winner_first)
        end
      end

      it 'eliminates choices for the lowest two candidate' do
        expect(race.winner).to eq winner
      end
    end
  end
end
