require 'factory_girl'
require 'ffaker'
require 'fileutils'
require 'open-uri'


def random(array, number=1)
  array.shuffle[0..(number - 1)].first
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

def rand_time(from, to)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

groups = []
tickets = []


ActiveRecord::Base.connection.execute("TRUNCATE users")
FactoryGirl.create(:user, :first_name => 'Matt', :last_name => 'Bergman', :email => "matt@novafabrica.com", :password => "password", :password_confirmation => "password", :enabled => true, :username => "fotoverite")
FactoryGirl.create(:user, :first_name => 'Kevin', :last_name => 'Skoglund', :email => "kevin@novafabrica.com", :password => "password", :password_confirmation => "password", :enabled => true, :username => "kskoglund")
FactoryGirl.create(:user, :first_name => 'Christoph', :last_name => 'Wiese', :email => "cw@xtoph.com", :password => "password", :password_confirmation => "password", :enabled => true, :username => "christoph")


ActiveRecord::Base.connection.execute("TRUNCATE ticket_groups")
4.times do
  users = []
  users << random(User.all)
  users + [random(User.all)] if random [0,1]
  users + [random(User.all)] if random [0,1]
  groups << FactoryGirl.create(:ticket_group, :name => Faker::Company.name)
end

for user in User.all do
  user.ticket_groups = groups
  user.save
end

ActiveRecord::Base.connection.execute("TRUNCATE tickets")
100.times do
  tickets << FactoryGirl.create(
    :ticket,
    :ticket_group => random(groups),
    :creator => random(User.all),
    :assignee => random(User.all),
    :name => Faker::Company.bs,
    :description => Faker::Lorem.paragraph(3),
    :status => random(['open', 'closed', 'pending']),
    :due_date => rand_time(Time.now, Time.now + 100.days))
end

ActiveRecord::Base.connection.execute("TRUNCATE comments")
tickets.each do |ticket|
  random([*1..10]).times do
    FactoryGirl.create(:comment,
      :ticket_id => ticket.id,
      :user => random(User.all),
      :content => Faker::Lorem.paragraph(5)
    )
  end
end