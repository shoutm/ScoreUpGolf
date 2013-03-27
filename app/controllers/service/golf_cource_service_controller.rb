class Service::GolfCourceServiceController < ApplicationController
  # == 概要
  # 引数に指定された属性を元にGolfCourceを取得する。
  # 指定されたGolfFieldのIDに対して該当するCource一覧を返却する。
  # 該当するGolfFieldが存在しない場合、必要な引数が与えられない場合はnullを返す
  #
  # == 引数
  # golf_field_id
  #
  # == 出力例
  # [
  #   {
  #     "id": 1234,
  #     "name": "コース1-1",
  #   },
  #   ...
  # ]
  def get_cources
    unless params[:golf_field_id]
      render json: nil; return 
    end
    cources = GolfCource.select([:id, :name]).where({golf_field_id: params[:golf_field_id]})
    cources = nil if cources.empty?

    respond_to do |format|
      format.json { render json: cources } 
    end
  end

end
