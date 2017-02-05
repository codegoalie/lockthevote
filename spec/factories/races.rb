FactoryGirl.define do
  factory :race do
    office FFaker::Company.position
    description FFaker::Company.bs
    election
  end

  factory :pick_two_race do
    office FFaker::Company.position
    description FFaker::Company.bs
    election
  end

  factory :ranked_race do
    office FFaker::Company.position
    description FFaker::Company.bs
    election
  end
end
