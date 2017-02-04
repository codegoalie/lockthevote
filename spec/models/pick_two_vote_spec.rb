require 'rails_helper'

RSpec.describe PickTwoVote do
  describe '#valid?' do
    it 'is false with three candidates' do
      vote = FactoryGirl.build :pick_two_vote, selection: '1,2,3'

      expect(vote.valid?).to be_falsey
      expect(vote.errors.messages.keys).to include(:selection)
      expect(vote.errors.messages[:selection]).to include \
        I18n.t('errors.pick_two_vote.selection.exactly_two')
    end

    it 'is false with non-existant selections' do
      vote = FactoryGirl.build :pick_two_vote, selection: '1,2'

      expect(vote.valid?).to be_falsey
      expect(vote.errors.messages.keys).to include(:selection)
      expect(vote.errors.messages[:selection]).to include \
        I18n.t('errors.pick_two_vote.selection.does_not_exist')
    end

    it 'is false for non-pick-two races' do
      vote = FactoryGirl.build :pick_two_vote,
                               selection: '1,2',
                               race: FactoryGirl.build(:race)

      expect(vote.valid?).to be_falsey
      expect(vote.errors.messages.keys).to include(:race)
      expect(vote.errors.messages[:race]).to include \
        I18n.t('errors.pick_two_vote.race.not_a_pick_two')
    end
  end
end
