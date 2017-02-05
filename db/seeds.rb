# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
#                          { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

elections = [
  {
    election: 'Federal and State',
    races: [
      {
        type: 'RankedRace',
        office_name: 'Commander in Cream and Vice Ice',
        candidates: [
          {
            name: 'ReeseWithoutASpoon - Democrat for C.I.C',
            description: 'Cherry Garcia - Democrat for Vice Ice'
          },
          {
            name:   "Choco 'Chip' Dough - Republican for C.I.C.",
            description: 'Carmela Coney - Republican for Vice Ice'
          },
          {
            name: 'Magic Browny - Independent for C.I.Complex',
            description: 'Phish Food - Independent for Vice Ice'
          }
        ]
      },
      {
        type: 'Race',
        office_name: 'Cheif Dairy Queen',
        office_description: 'Shall Justice Mint C. Chip of the Supreme Court ' \
        'of the State of Ice Cream be retained in office for another term?',
        candidates: [
          { name: 'Yes' },
          { name: 'No' }
        ]
      },
      {
        type: 'PickTwoRace',
        office_name: 'State Rep. District M&M',
        candidates: [
          { name: 'P. Nut Butter (Republican)' },
          { name: 'Cream C. Kol (Independent)' },
          { name: 'Marsh Mallow (Democrat)' }
        ]
      }
    ]
  },
  {
    election: 'County',
    races: [
      {
        type: 'Race',
        office_name: 'Constitutional Initiative No. 116',
        office_description: 'Make vanilla (over chocolate) the official best ' \
        'flavor',
        candidates: [
          { name: 'Yes on CI - 116 (For vanilla)' },
          { name: 'No on CI - 116 (No on vanilla)' }
        ]
      }
    ]
  }
]

elections.each do |data|
  election = Election.find_or_initialize_by(name: data[:election])
  unless election.persisted?
    election.update_attributes!(starts_at: 1.days.ago, ends_at: 1.week.from_now)
  end
  election.save!

  data[:races].each do |race_data|
    race = Race.find_or_initialize_by(office: race_data[:office_name],
                                      type: race_data[:type],
                                      election_id: election.id)
    race.update_attributes!(description: race_data[:office_description])

    race_data[:candidates].each do |params|
      race.candidates << Candidate.find_or_initialize_by(params)
    end
    race.save!

    (rand * 10).round.times do
      case race.type
      when 'PickTwoRace'
        race.record_vote(FactoryGirl.create(:user), race.candidates.sample(2))
      when 'RankedRace'
        race.record_vote(FactoryGirl.create(:user), race.candidates.shuffle)
      else
        race.record_vote(FactoryGirl.create(:user), race.candidates.sample)
      end
    end
  end
end
