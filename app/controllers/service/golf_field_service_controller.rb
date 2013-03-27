class Service::GolfFieldServiceController < ApplicationController
  # == 概要
  # 引数に指定された属性を元にGolfField検索を実施する。
  # 指定された属性に対してlike検索を実施する。
  # 該当するGolfFieldが存在しない場合、必要な引数が与えられない場合はnullを返す
  #
  # == 引数
  # name
  #
  # == 出力例
  # [
  #   {
  #     "id": 1234,
  #     "name": "ゴルフ場1",
  #     "region": 100
  #   },
  #   ...
  # ]
  def search
    unless params[:name]
      render json: nil; return 
    end
    search_cond = "%" + params[:name] + "%"
    fields = GolfField.select([:id, :name, :region]).where "name like '#{search_cond}'"
    fields = nil if fields.empty?

    respond_to do |format|
      format.json { render json: fields } 
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: nil
  end
end
