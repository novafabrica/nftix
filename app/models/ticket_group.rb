class TicketGroup < ActiveRecord::Base
  has_many :tickets
end
