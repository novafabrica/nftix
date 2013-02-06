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

end
