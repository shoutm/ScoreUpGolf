class Portal::FriendController < ApplicationController
  def index
    @friends = @user.friends
  end

end
