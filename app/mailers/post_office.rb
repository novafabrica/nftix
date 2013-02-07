class PostOffice < ActionMailer::Base
  default :from => "example@example.com"

  def password_reset(member)
    @member = member
    @url = reset_password_url(:token => member.password_token)
    mail(
      :to => member.email,
      :subject => "#{BRAND} - Forgot Password",
      :reply_to => member.email
    )
  end

  def send_comment(ticket, comment, users)
    @content = ticket.content
    mail(
      :recipients => users.map {|u| u.email},
      :subject => ticket.title,
      :reply_to => "comments-#{ticket.id}@nftixs.com"
    )
  end

end
