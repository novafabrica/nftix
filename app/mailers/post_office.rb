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

  def send_comment(ticket, comment, recipients)
    @ticket = ticket
    @comment = comment
    @recipients = recipients.map {|r| r.full_name}.to_sentence
    mail(
      :to => recipients.map {|r| r.email },
      :subject => ticket.name,
      :reply_to => "comments-#{ticket.id}@nftixs.com"
    )
  end

end
