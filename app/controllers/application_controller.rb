class ApplicationController < ActionController::Base
  include SessionMethods
  include NovaFabrica::BasicControllerMethods
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :correct_accept_headers
  before_filter :http_authenticate
  before_filter :confirm_logged_in

  layout 'application'

  USERS = { 'kskoglund'   => 'Forgetful1',
            'fotoverite'  => 'Novafab#1234',
            'client'      => 'alpha#4321',
            'tester'      => 'kvadrat#pricing' }

  def http_authenticate
    return if ['development', 'test', 'production'].include?(Rails.env)
    authenticate_or_request_with_http_basic do |username, password|
      USERS.fetch(username, false) == password
    end
  end

  def correct_accept_headers
    # Used to fix acceptence header in ie and safari.
    # NB remember sort needs to modify so keep it sort!
    request.accepts.sort! { |x, y| y.to_s == "text/javascript" ? 1 : -1 } if request.xhr?
  end

  # overrides NovaFabrica::BasicControllerMethods#render_404
  def render_404
    respond_to do |type|
      type.html { render :file => "application/error_page_404", :status => 404 }
      type.all  { render :nothing => true, :status => 404 }
    end
    true  # so we can do "render_404 and return"
  end

  # overrides NovaFabrica::BasicControllerMethods#render_500
  def render_500
    respond_to do |type|
      type.html { render :file => "application/error_page_500", :status => 500 }
      type.all  { render :nothing => true, :status => 500 }
    end
    true  # so we can do "render_500 and return"
  end

  protected

    def confirm_logged_in
      unless logged_in?
        session[:desired_url] = url_for(params)
        respond_to do |format|
          format.html {
            flash[:notice] = "Please log in."
            redirect_to(login_path) and return false
          }
          format.json {
            render(:json => {:result => "Please log in."}) and return false
          }
        end
      end
      return true
    end

    def confirm_not_logged_in
      if logged_in?
        respond_to do |format|
          format.html {
            flash[:notice] = "You are already logged in."
            redirect_to(login_path) and return false
          }
          format.json {
            render(:json => {
              :result => "You are already logged in."
            }) and return false
          }
        end
      end
      return true
    end

end