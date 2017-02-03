FactoryGirl.define do
  factory :user do
    sequence :email do |sn|
      FFaker::Internet.safe_email "#{FFaker::Name.name} #{sn}"
    end
    password Devise.friendly_token[0, 20]
  end
end
