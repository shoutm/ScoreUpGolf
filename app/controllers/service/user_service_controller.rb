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
end
