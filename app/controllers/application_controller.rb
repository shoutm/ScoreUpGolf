class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :login_check

  def login_check
    # TODO openid での認証
    @user = User.find(:first, conditions: ["email = :email", {email: "user1@test.com"}])   
  end
end
