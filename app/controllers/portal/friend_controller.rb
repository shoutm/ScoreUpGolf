class Portal::FriendController < ApplicationController
  def index
    @friends = @user.friends
  end

  def search 
  end

  def show 
    @friend = nil
    if params[:user_id]
      @friend = User.find(params[:user_id])
      tmp = @user.friend_relations.find do |fr| fr.friend_id == @friend.id end 
      @friend_state = tmp.state if tmp
    end
  end
end
