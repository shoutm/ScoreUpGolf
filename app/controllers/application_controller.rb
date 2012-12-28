require 'ruby-debug'
class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :set_layout
  before_filter :login_check

  def set_layout
    smartphone_request? ? "smartphone" : "application"
  end

  def login_check
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to controller: "/session", action: :login
    end
  rescue Exception => ex
    redirect_to controller: "/session", action: :login
  end

  private 
  def smartphone_request?
    request.user_agent =~ /(Mobile.+Safari)/
  end

end
