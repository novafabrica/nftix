FactoryGirl.define do

  factory :comment do
    content Faker::Lorem.paragraph(3)
  end

end