FactoryGirl.define do

  factory :ticket do
    name Faker::Company.bs
    description Faker::Lorem.paragraph(3)
    status ['open', 'closed', 'pending'].shuffle[0..(0)].first
    ticket_group {|a| a.association(:ticket_group) }
  end



end

