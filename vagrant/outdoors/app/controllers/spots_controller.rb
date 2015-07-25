class SpotsController < ApplicationController
  before_filter :require_login

  def index
    #評価済みのスポット情報を取得し、全て評価済みか判定
    if current_user.spots.count < Spot.all.count
      redirect_to :action => "new"
    else
      redirect :show
    end
  end

  def show
  end

  def new
    rated_spot_ids = current_user.spots.map(&:id)
    @unrated_spots = Spot.where.not(id: rated_spot_ids)
  end
end
