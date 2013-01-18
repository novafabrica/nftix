module NovaFabrica

  module BasicControllerMethods

    def order_using_params
      params[:order] ? "#{params[:order]} #{params[:dir]}" : nil
    end

    def render_404
      render(:file => "#{Rails.root}/public/404.html", :status => 404) and return
    end

    def render_500
      render(:file => "#{Rails.root}/public/500.html", :status => 500) and return
    end

    def get_nice_password
      NicePassword.new(:length => 12, :words => 2, :digits => 2)
    end

    def redirect_to_desired_url(fallback_url={:action => 'index'})
      if session[:desired_url]
        desired_url = session[:desired_url]
        session[:desired_url] = nil
        redirect_to(desired_url)
      else
        redirect_to(fallback_url)
      end
    end

  end

end
