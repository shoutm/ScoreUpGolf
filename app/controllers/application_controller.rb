require 'ruby-debug'
class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :set_layout
  before_filter :login_check

  def set_layout
    smartphone_request? ? "smartphone" : "application"
  end

  def login_check
    # TODO openid での認証
    @user = User.find(:first, conditions: ["email = :email", {email: "user1@test.com"}])   
  end

  private 
  def smartphone_request?
    request.user_agent =~ /(Mobile.+Safari)/
  end

end
