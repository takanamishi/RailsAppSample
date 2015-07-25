class SpotsController < ApplicationController
  before_filter :require_login

  def index
    @user = current_user

    #評価済みのスポット情報を取得
    @rated_spots = @user.spots

    #全て評価済みか判定
    if @rated_spots.count < Spot.all.count
      rated_spot_ids = @rated_spots.map(&:id)
      @unrated_spots = Spot.where.not(id: rated_spot_ids)
    else
      #showページにリダイレクトする処理を実装する
    end
  end

  def show
  end
end
