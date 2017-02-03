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
        office_name: 'Commander in Cream and Vice Ice',
        candidates: [
          "ReeseWithoutASpoon - Democrat for C.I.C\nCherry Garcia - Democrat " \
          'for Vice Ice',
          "Choco 'Chip' Dough - Republican for C.I.C.\nCarmela Coney - " \
          'Republican for Vice Ice',
          "Magic Browny - Independent for C.I.Complex\nPhish Food - " \
          'Independent for Vice Ice'
        ]
      },
      {
        office_name: 'Cheif Dairy Queen',
        office_description: 'Shall Justice Mint C. Chip of the Supreme Court ' \
        'of the State of Ice Cream be retained in office for another term?',
        candidates: %w(Yes No)
      },
      {
        office_name: 'State Rep. District M&M',
        candidates: [
          'P. Nut Butter (Republican)',
          'Cream C. Kol (Independent)',
          'Marsh Mallow (Democrat)'
        ]
      }
    ]
  },
  {
    election: 'County',
    races: [
      {
        office_name: 'Constitutional Initiative No. 116',
        office_description: 'Make vanilla (over chocolate) the official best ' \
        'flavor',
        candidates: [
          'Yes on CI - 116 (For vanilla)',
          'No on CI - 116 (No on vanilla)'
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
                                      election_id: election.id)
    race.update_attributes!(description: race_data[:office_description])

    race_data[:candidates].each do |name|
      race.candidates << Candidate.find_or_initialize_by(name: name)
    end
    race.save!

    (rand * 10).round.times do
      Vote.create!(voter: FactoryGirl.create(:user),
                   race: race,
                   selection: race.candidates.sample)
    end
  end
end
