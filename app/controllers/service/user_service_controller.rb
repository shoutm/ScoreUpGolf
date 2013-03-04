class Service::UserServiceController < ApplicationController
  # == 概要
  # 引数に指定された属性を元にUser検索を実施する。
  # 指定された属性に対してlike検索を実施する。
  # 該当するUserが存在しない場合、必要な引数が与えられない場合はnullを返す
  # ただし、Roleが管理者のユーザは返さない
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
      search_cond << "name like ? and role = ?"
      search_cond << "%" + params[:name] + "%"
      search_cond << User::Role::User
    elsif params[:name] == nil && params[:email] != nil
      search_cond << "email like ? and role = ?"
      search_cond << "%" + params[:email] + "%"
      search_cond << User::Role::User
    else
      search_cond << "name like ? and email like ? and role = ?"
      search_cond << "%" + params[:name] + "%"
      search_cond << "%" + params[:email] + "%"
      search_cond << User::Role::User
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
  # ただし、Roleが管理者のユーザは返さない
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
      search_cond << "id != ? and name like ? and role = ?"
      search_cond << @user.id
      search_cond << "%" + params[:name] + "%"
      search_cond << User::Role::User
    elsif params[:name] == nil && params[:email] != nil
      search_cond << "id != ? and email like ? and role = ?"
      search_cond << @user.id
      search_cond << "%" + params[:email] + "%"
      search_cond << User::Role::User
    else
      search_cond << "id != ? and name like ? and email like ? and role = ?"
      search_cond << @user.id
      search_cond << "%" + params[:name] + "%"
      search_cond << "%" + params[:email] + "%"
      search_cond << User::Role::User
    end
    
    users = User.find(:all, conditions: search_cond, select: [:id, :name, :email])
    if users == [] then render json: nil; return end

    fr_hash = {}
    @user.friend_relations.each do |fr| fr_hash[fr.friend_id] = fr.state end

    users_json = JSON.parse(users.to_json)
    users_json.each do |user_json| user_json["friend_state"] = fr_hash[user_json["id"]] if fr_hash[user_json["id"]] end

    respond_to do |format|
      format.json { render json: users_json } 
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: nil
  end

  # == 概要
  # 引数に指定された属性を元にUser検索を実施する。
  # 指定された属性に対してlike検索を実施する。
  # 本APIを実行したユーザと友人間系にあるユーザのみを返す。
  # 結果には検索を実施したユーザ自身の情報は含めない。
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
  def search_friend
    search_cond = []
    if params[:name] == nil && params[:email] == nil 
      render json: nil ; return
    elsif params[:name] != nil && params[:email] == nil
      search_cond << "users.id != ? and users.name like ? and users.role = ? and friend_relations.state = ? and friend_relations.user_id = ?"
      search_cond << @user.id
      search_cond << "%" + params[:name] + "%"
      search_cond << User::Role::User
      search_cond << FriendRelation::State::BE_FRIENDS 
      search_cond << @user.id
    elsif params[:name] == nil && params[:email] != nil
      search_cond << "users.id != ? and users.email like ? and users.role = ? and friend_relations.state = ? and friend_relations.user_id = ?"
      search_cond << @user.id
      search_cond << "%" + params[:email] + "%"
      search_cond << User::Role::User
      search_cond << FriendRelation::State::BE_FRIENDS 
      search_cond << @user.id
    else
      search_cond << "users.id != ? and users.name like ? and users.email like ? and users.role = ? and friend_relations.state = ? and friend_relations.user_id = ?"
      search_cond << @user.id
      search_cond << "%" + params[:name] + "%"
      search_cond << "%" + params[:email] + "%"
      search_cond << User::Role::User
      search_cond << FriendRelation::State::BE_FRIENDS 
      search_cond << @user.id
    end

    users = User.find(:all, joins: "inner join friend_relations on users.id = friend_relations.friend_id", 
                      conditions: search_cond, 
                      select: [:"users.id", :"users.name", :"users.email"])
    if users == [] then render json: nil; return end

    respond_to do |format|
      format.json { render json: users } 
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: nil
  end
end
