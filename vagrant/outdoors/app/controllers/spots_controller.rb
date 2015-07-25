class SpotsController < ApplicationController
  before_filter :require_login

  def index
    #評価済みのスポット情報を取得し、全て評価済みか判定
    if current_user.spots.count < Spot.all.count
      redirect_to :action => "new"
    else
      redirect_to :action => "show"
    end
  end

  def show
  end

  def new
    @spot = Spot.new

    rated_spot_ids = current_user.spots.map(&:id)
    @unrated_spots = Spot.where.not(id: rated_spot_ids)
  end

  def create
    judgments = params[:spot_id]

    judgments.each do |judgment|
      current_user.user_spots.create(spot_id: judgment[0], judgment: judgment[1])
    end

    redirect_to spots_url, notice: "登録が完了しました。"
  end
end
