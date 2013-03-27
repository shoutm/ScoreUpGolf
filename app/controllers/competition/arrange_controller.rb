require 'date'

class Competition::ArrangeController < ApplicationController
  def index
    initialize_index_page
  end

  def confirm
    error_msgs = check_errors(params)
    unless error_msgs.empty?
      flash[:alert] = error_msgs
      redirect_to action: :index
      return
    end

    initialize_confirm_page
  end

  def finish
    error_msgs = check_errors(params)
    unless error_msgs.empty?
      flash[:alert] = error_msgs
      redirect_to action: :index
      return
    end

    ActiveRecord::Base.transaction do
      c = Competition.new({name: params[:competition_name], golf_field_id: params[:golf_field_id], 
        competition_date: DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i), 
        firsthalf_cource_id: params[:firsthalf_cource_id], secondhalf_cource_id: params[:secondhalf_cource_id],
        host_user_id:  @user.id, state: Competition::State::ARRANGED})
      throw Exception unless c.save
      p = Party.new({party_no: 1, competition_id: c.id, reverse_cource_order: false})
      throw Exception unless p.save
      [params[:user1_id], params[:user2_id], params[:user3_id], params[:user4_id]].compact.each do |uid|
        player = Player.new({party_id: p.id, user_id: uid, state: Player::State::JOINED})
        player.save
      end
    end
  rescue => e
    redirect_to action: :index
  end

  private 

  def initialize_index_page
    @today = Date.today
    @years = [@today.year, @today.year + 1] 
    @months = []; (1..12).each do |m| @months << m end
    @days = []; (1..31).each do |d| @days << d end
  end

  def initialize_confirm_page
    @competition_name = params[:competition_name]
    @competition_date = Date.new(params[:year].to_i ,params[:month].to_i ,params[:day].to_i)
    user_ids = [params[:user1_id], params[:user2_id], params[:user3_id], params[:user4_id]]
    @users = convert_user_ids_to_users(user_ids)
    @golf_field = GolfField.find(params[:golf_field_id].to_i)
    @firsthalf_cource = GolfCource.find(params[:firsthalf_cource_id].to_i)
    @secondhalf_cource = GolfCource.find(params[:secondhalf_cource_id].to_i)
  end

  # return error message
  def check_errors(params)
    error_msgs = []

    lack_params = get_lack_parameters(params)
    unless lack_params.empty?
      error_msgs << "Required parameters are not given: " + lack_params.join(", ")
    end

    if wrong_date?(params[:year], params[:month], params[:day])
      error_msgs << "Given date is wrong format."
    end

    user_ids = [params[:user1_id], params[:user2_id], params[:user3_id], params[:user4_id]]
    unless check_friends? user_ids
      error_msgs << "You can arrange competition only with your friends."
    end

    unless user_ids.compact.size == user_ids.uniq.compact.size
      error_msgs << "Same users exist in members."
    end

    unless user_ids.include? @user.id.to_s
      error_msgs << "You can not arrange competition without you."
    end

    unless check_relations_between_golf_field_and_cources(
      params[:golf_field_id], params[:firsthalf_cource_id] , params[:secondhalf_cource_id])
      error_msgs << "Invalid golf field or cources."
    end

    return error_msgs
  end

  # return param names(symbol) if required parameters are not presented.
  def get_lack_parameters(params)
    lack_params = []
    lack_params << :competition_name     if params[:competition_name].nil?
    lack_params << :year                 if params[:year].nil?
    lack_params << :month                if params[:month].nil?
    lack_params << :day                  if params[:day].nil?
    lack_params << :user                 if params[:user1_id].nil? && params[:user2_id].nil? &&
                                            params[:user3_id].nil? && params[:user4_id].nil?
    lack_params << :golf_field_id        if params[:golf_field_id].nil?
    lack_params << :firsthalf_cource_id  if params[:firsthalf_cource_id].nil?
    lack_params << :secondhalf_cource_id if params[:secondhalf_cource_id].nil?

    return lack_params
  end

  def wrong_date?(year, month, day)
    if Date.valid_date?(Integer(year), Integer(month), Integer(day))
      return false
    end

    return true
  rescue Exception => e 
    return true
  end

  def check_friends?(user_ids)
    users = convert_user_ids_to_users(user_ids)
    return false unless user_ids.compact.size == users.size 

    users.each do |user1|
      users.each do |user2|
        next if user1 == user2 
        return false unless FriendRelationUtils::friends?(user1, user2, FriendRelation::State::BE_FRIENDS)
      end
    end

    return true
  end

  def convert_user_ids_to_users(user_ids)
    users = []
    user_ids.each do |id| 
      users << User.find_by_id(id.to_i)
    end

    return users.compact
  end

  def check_relations_between_golf_field_and_cources(golf_field_id, first_id, second_id)
    first  = GolfCource.find(first_id.to_i)
    second = GolfCource.find(second_id.to_i)
    if first.golf_field_id == second.golf_field_id &&
       first.golf_field_id == golf_field_id.to_i
      return true
    end

    return false
  rescue ActiveRecord::RecordNotFound => e
    return false
  end
end
