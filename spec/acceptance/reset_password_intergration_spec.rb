require 'acceptance/acceptance_helper'

feature 'Resetting a users password'  do

  background do
    @user = FactoryGirl.create(:user)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  scenario "when successfully resetting a password" do
    visit '/forgot-password'
    page.should have_content('Forgot Password')
    fill_the_following({
        "Email" => @user.email
    })
    click_button('Send Email')
    unread_emails_for(@user.email).size.should >= parse_email_count(1)
    email = open_email(@user.email)
    current_email.should have_subject("NFTixs - Forgot Password")
    visit_in_email(reset_password_url(@user.password_token))
    current_path.should == reset_password_path(:token => @user.reload.password_token)
    fill_the_following({
        "user_password" => 'password1',
        "Password Confirmation" => 'password1'
    })
    click_button('Reset Password')
    current_path.should == root_path

  end

  scenario "when successfully unsuccesffuly resetting" do
    visit '/forgot-password'
    page.should have_content('Forgot Password')
    fill_the_following({
        "Email" => @user.email
    })
    click_button('Send Email')
    unread_emails_for(@user.email).size.should >= parse_email_count(1)
    email = open_email(@user.email)
    current_email.should have_subject("NFTixs - Forgot Password")
    visit_in_email(reset_password_url(@user.reload.password_token))
    current_path.should == reset_password_path(:token => @user.password_token)
    fill_the_following({
        "user_password" => 'password',
        "Password Confirmation" => 'error'
    })
    click_button('Reset Password')
    current_path.should == '/update_reset_password'
  end

  scenario "a person visits the reset password path with bad token" do
    visit reset_password_path("error")
    page.should have_content('The password could not be reset')
  end

end
