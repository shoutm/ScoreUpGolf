class Service::UserServiceController < ApplicationController
  # == 概要
  # 引数に指定された属性を元にUser検索を実施する。
  # 指定された属性に対してlike検索を実施する。
  # 該当するUserが存在しない場合、必要な引数が与えられない場合はnullを返す
  #
  # == 引数
  # name
  # email
  #
  # == 出力例
  # [
  #   {
  #     "id": 1234,
  #     "name": "User1",
  #     "email": "user1@gmail.com"
  #   },
  #   ...
  # ]
  def search
    search_cond = []
    if params[:name] == nil && params[:email] == nil 
      render json: nil ; return
    elsif params[:name] != nil && params[:email] == nil
      search_cond << "name like ?"
      search_cond << "%" + params[:name] + "%"
    elsif params[:name] == nil && params[:email] != nil
      search_cond << "email like ?"
      search_cond << "%" + params[:email] + "%"
    else
      search_cond << "name like ? and email like ?"
      search_cond << "%" + params[:name] + "%"
      search_cond << "%" + params[:email] + "%"
    end
    
    users = User.find(:all, conditions: search_cond, select: [:id, :name, :email])
    users = nil if users == []

    respond_to do |format|
      format.json { render json: users } 
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: nil
  end

  # == 概要
  # 引数に指定された属性を元にUser検索を実施する。
  # 指定された属性に対してlike検索を実施する。
  # 結果には検索を実施したユーザ自身の情報は含めない。
  # 結果には検索を実施したユーザとのfriend関係を示すフラグも含める。
  # 該当するUserが存在しない場合、必要な引数が与えられない場合はnullを返す
  #
  # == 引数
  # name
  # email
  #
  # == 出力例
  # [
  #   {
  #     "id": 1234,
  #     "name": "User1",
  #     "email": "user1@gmail.com",
  #     "friend_state": 10          # values of FriendRelation::State
  #   },
  #   ...
  # ]
  def search_with_friendstate
    search_cond = []
    if params[:name] == nil && params[:email] == nil 
      render json: nil ; return
    elsif params[:name] != nil && params[:email] == nil
      search_cond << "id != ? and name like ?"
      search_cond << @user.id
      search_cond << "%" + params[:name] + "%"
    elsif params[:name] == nil && params[:email] != nil
      search_cond << "id != ? and email like ?"
      search_cond << @user.id
      search_cond << "%" + params[:email] + "%"
    else
      search_cond << "id != ? and name like ? and email like ?"
      search_cond << @user.id
      search_cond << "%" + params[:name] + "%"
      search_cond << "%" + params[:email] + "%"
    end
    
    users = User.find(:all, conditions: search_cond, select: [:id, :name, :email])
    if users == [] then render json: nil; return end

    join_cond = "inner join friend_relations on users.id = friend_relations.user_id"
    search_cond[0].gsub! /id/, "users.id"
    search_cond[0].gsub! /name/, "users.name"
    search_cond[0].gsub! /email/, "users.email"
    search_cond[0].concat " and friend_relations.friend_id = ?"
    search_cond << @user.id

    rel_users = User.find(:all, joins: join_cond, conditions: search_cond)
    rel_users_hash = {}
    rel_users.each do |rel_user| rel_users_hash[rel_user.id] = rel_user.friend_relations[0].state end

    users_json = JSON.parse(users.to_json)
    users_json.each do |user_json| user_json["friend_state"] = rel_users_hash[user_json["id"]] if rel_users_hash[user_json["id"]] end

    respond_to do |format|
      format.json { render json: users_json } 
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: nil
  end
end
