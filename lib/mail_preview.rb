class MailPreview < MailView

  FactoryGirl.find_definitions

  def password_reset
    user = FactoryGirl.build(:user, :password_token => "token")
    PostOffice.password_reset(user)
  end

  def send_comment
    ticket_group = FactoryGirl.build(:ticket_group)
    user = FactoryGirl.build(:user,  :ticket_groups => [ticket_group])
    user2 = FactoryGirl.build(:user,  :ticket_groups => [ticket_group])
    commenter = FactoryGirl.build(:user, :ticket_groups => [ticket_group])
    ticket = FactoryGirl.build(:ticket, :ticket_group => ticket_group, :creator => user)
    comment = FactoryGirl.build(:comment, :ticket => ticket, :user => commenter)
    PostOffice.send_comment(ticket, comment, [user, user2])
  end

end