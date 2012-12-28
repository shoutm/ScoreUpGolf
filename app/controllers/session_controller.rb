class SessionController < ApplicationController
  skip_before_filter :login_check

  def login
  end

  def callback
    if request.env["omniauth.auth"] && request.env["omniauth.auth"].provider && request.env["omniauth.auth"].uid
      case request.env["omniauth.auth"].provider
      when "facebook"
        ua = UserAttribute.find(:first, conditions: {key: UserAttribute::OPENID_FACEBOOK, value: request.env["omniauth.auth"].uid})
        session[:user_id] = ua.user_id if ua
      end
    end

    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
  end
end
