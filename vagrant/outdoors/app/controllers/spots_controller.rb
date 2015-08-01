class SpotsController < ApplicationController
  def index
    #評価済みのスポット情報の件数を取得し、全て評価済みか判定
    unrated_spot_count = UserSpot.where(user_id: current_user.id).count

    if unrated_spot_count < Spot.all.count
      redirect_to :action => "new"
    else
      @rated_spots = current_user.spots
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
      if current_user.user_spots.create(spot_id: judgment[0], judgment: judgment[1]).valid?
      else
        redirect_to spots_url, notice: "登録に失敗しました。"
        break
      end
    end

    redirect_to spots_url, notice: "登録が完了しました。"
  end
end
