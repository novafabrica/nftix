module SessionMethods

  protected

    def logged_in?
      unless current_user(User)
        return false
      else
        return true
      end
    end

    def current_user(klass=User)
      class_name = get_klass_name(klass)
      unless @current_user == false
        @current_user ||= (login_from_session(klass) || login_from_cookie(klass))
        instance_variable_set("@current_#{class_name}".to_sym, @current_user)
        return  @current_user
      end
    end

    def current_user=(new_user, &block)
      session["#{get_klass_name(new_user)}_id".to_sym] = new_user ? new_user.id : nil
      yield if block_given?
      @current_user = new_user || false
    end

    def login_from_session(klass)
      class_name = get_klass_name(klass)
      user = klass.find_by_id(session["#{class_name}_id".to_sym])
      if user
        if user.enabled
          self.current_user = user
        else
          logout_keeping_session!(class_name)
        end
      end
    end

    def login_from_cookie(klass)
      class_name = get_klass_name(klass)
      auth_token = "#{class_name}_auth_token".to_sym
      user =  klass.find_by_remember_token(cookies[auth_token]) if (cookies[auth_token])
      if user && user.remember_token?
        if user.enabled
          self.current_user = user
          handle_remember_cookie! false, class_name # freshen cookie token (keeping date)
          return self.current_user
        else
          logout_keeping_session!(class_name)
        end
      end
    rescue
      logout_killing_session!(class_name)
    end

    # The session should only be reset at the tail end of a form POST --
    # otherwise the request forgery protection fails. It's only really necessary
    # when you cross quarantine (logged-out to logged-in).
    def logout_killing_session!(class_name)
      logout_keeping_session!(class_name)
      reset_session
    end

    def logout_keeping_session!(class_name, &block)
      # Kill server-side auth cookie
      @current_user.forget_me if @current_user
      @current_user = false
      kill_remember_cookie!(class_name)     # Kill client-side auth cookie
      session["#{class_name}_id".to_sym] = nil
      yield if block_given?
      # explicitly kill any other session variables you set
    end

    def kill_remember_cookie!(class_name)
      cookies.delete "#{class_name}_auth_token".to_sym
    end

    def valid_remember_cookie?(class_name)
      return nil unless @current_user
      (@current_user.remember_token?) &&
        (cookies["#{class_name}_auth_token".to_sym] == @current_user.remember_token)
    end

    def send_remember_cookie!(class_name)
      cookies["#{class_name}_auth_token".to_sym] = {
        :value   => @current_user.remember_token,
        :expires => @current_user.remember_token_expires_at
      }
    end

    # Refresh the cookie auth token if it exists, create it otherwise
    def handle_remember_cookie!(new_cookie_flag, class_name)
      return unless  @current_user
      case
      when valid_remember_cookie?(class_name) then  @current_user.refresh_token # keeping same expiry date
      when new_cookie_flag        then  @current_user.remember_me
      else                              @current_user.forget_me
      end
      send_remember_cookie!(class_name)
    end

    def get_klass_name(klass)
      klass.respond_to?(:name) ? klass.name.tableize.singularize : klass.class.name.tableize.singularize
    end


end
