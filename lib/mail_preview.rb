class MailPreview < MailView
  FactoryGirl.find_definitions

  def password_reset
    user = FactoryGirl.build(:user, :password_token => "token")
    PostOffice.password_reset(user)
  end

end