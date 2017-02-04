require 'rails_helper'

RSpec.describe Vote do
  describe '#valid?' do
    it 'is false with non-existant selections' do
      vote = FactoryGirl.build :vote, selection: '2'

      expect(vote.valid?).to be_falsey
      expect(vote.errors.messages.keys).to include(:selection)
      expect(vote.errors.messages[:selection]).to include \
        I18n.t('errors.vote.selection.does_not_exist')
    end
  end
end
