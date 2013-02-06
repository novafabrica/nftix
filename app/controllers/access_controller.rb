class AccessController < ApplicationController

  before_filter :confirm_logged_in, :only => [:destroy]

  def new
    @container_class = "centered"
    # display login form
    @username = ''
  end

  def create
    @container_class = "centered"
    logout_keeping_session!('User')
    user = User.authenticate(params['username'], params['password'])
    if user && user.enabled?
      self.current_user = user
      flash[:notice] = "You are now logged in."
      redirect_to_desired_url(root_path)
    elsif user && !user.enabled?
      flash.now[:error] = "Your account is disabled".html_safe
      @username = params['username']
      render('new')
    else
      flash.now[:error]= "Username/password combination not found. Please try again."
      @username = params['username']
      render('new')
    end
  end

  def destroy
    logout_keeping_session!('user')
    flash[:notice] = "You are now logged out."
    redirect_to(root_path)
  end


  # Password Methods

  def forgot_password
    @container_class = "centered"
    # display form
  end

  def send_reset_password
    @user = User.where(:email => params[:email], :enabled => true).first
    if @user
      @user.create_password_token
      @user.email_reset_token
      render('reset_password_sent')
    else
      flash.now[:error] = "Email not found"
      render("forgot_password")
    end
  end

  def reset_password
    @user = User.find_by_password_token(params[:token])
    # NB: a blank params[:token] will find members without password_token
    if @user && @user.password_token.present?
      @container_class = "centered"
      render('reset_password')
    else
      @container_class = "centered large"
      render('reset_password_failed')
    end
  end

  def update_reset_password
    @user = User.find_by_password_token(params[:token])
    unless @user && @user.password_token.present?
      render_404 and return
    end
    # TODO: could we just call valid? here instead
    if params[:user][:password].blank?
      @user.errors.add(:password, "cannot be left blank")
      render('reset_password')
    else
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      @user.password_token = nil
      if @user.save
        self.current_user = @user
        flash[:notice] = "You are now logged in."
        redirect_to root_path
      else
        render('reset_password')
      end
    end
  end

  def get_password_idea
    render(:text => get_nice_password)
  end

end
