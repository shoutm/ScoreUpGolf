class Portal::FriendController < ApplicationController
  def index
    @friends = @user.friends
  end

  def search 
  end

end
