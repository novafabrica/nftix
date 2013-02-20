require 'spec_helper'

describe AccessController do

  before(:all) do
    @user = FactoryGirl.create(:user, :enabled => true)
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  describe "POST 'create'" do

    before(:each) do
    end

    it "should call authenticate on User with the params given" do
      User.should_receive(:authenticate).with(@user.email, "password").and_return(@user)
      post_create
    end

    it "should log in the user" do
      post_create
      session[:user_id].should == @user.id
    end

    it "should flash notice if the user is not found" do
      post :create, :username => @user.email, :password => "bad_password"
      flash[:error].should_not be_nil
    end

    def post_create
      post :create, :email => @user.email, :password => "password"
    end

  end

  describe "DELETE 'logout'" do

    before(:each) do
      session['user_id'] = @user.id
    end

    it "should log the user out" do
      session[:user_id].should == @user.id
      delete_destroy
      session[:user_id].should == nil
    end


    def delete_destroy
      delete :destroy
    end

  end

end