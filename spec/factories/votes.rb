FactoryGirl.define do
  factory :candidate do
    name FFaker::Name.name
    description FFaker::Job.title
    race
  end

  factory :vote do
    race
    association :voter, factory: :user, strategy: :build

    selection do
      (Candidate.first || FactoryGirl.create(:candidate)).id.to_s
    end
  end

  factory :pick_two_vote do
    association :race, factory: :pick_two_race, strategy: :build
    selection do
      first_selection = (Candidate.first || FactoryGirl.create(:candidate))
      second_selection = (Candidate.not.where(id: first_selection.id).first || \
                          FactoryGirl.create(:candidate))

      [first_selection.id.to_s, second_selection.id.to_s].join(',')
    end
  end

  factory :election do
    name FFaker::CheesyLingo.title
    starts_at { 1.day.ago }
    ends_at { 7.days.from_now }
  end
end
