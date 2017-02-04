FactoryGirl.define do
  factory :race do
    office FFaker::Company.position
    description FFaker::Company.bs
    election
  end

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

  factory :election do
    name FFaker::CheesyLingo.title
    starts_at { 1.day.ago }
    ends_at { 7.days.from_now }
  end
end
