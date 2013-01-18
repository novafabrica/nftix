FactoryGirl.define do

  sequence :name do |n|
    "username#{n}"
  end

  sequence :link_name do |n|
    "link_name#{n}"
  end

  sequence :position do |n|
    n
  end

  sequence :email do |n|
    "basic_email#{n}@gmail.com"
  end

  factory :user do |u|
    u.first_name "John"
    u.last_name "Doe"
    u.username { FactoryGirl.generate(:name) }
    u.email { FactoryGirl.generate(:email) }
    u.password "password123"
    u.password_confirmation "password123"
  end

end
