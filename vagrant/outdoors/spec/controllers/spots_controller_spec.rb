require 'rails_helper'

RSpec.describe SpotsController, :type => :controller do
  fixtures :users, :spots

  before do
    @user = users(:testuser)

    login_user(@user)
  end

  after do
    logout_user
  end

  describe "GET index" do
    it "ログインしていなければ、トップページにリダイレクトされること" do
      logout_user
      get :index
      expect(response).to redirect_to root_path
    end

    it "User.spotsが0件の場合、newにリダイレクトすること" do
      get :index
      expect(response).to redirect_to(:action => 'new')
    end

    it "スポット情報が全て評価済みの場合、indexが表示されること" do
      @user.user_spots.create(spot_id: 1, judgment: 1)
      @user.user_spots.create(spot_id: 2, judgment: 1)
      @user.user_spots.create(spot_id: 3, judgment: 1)
      @user.user_spots.create(spot_id: 4, judgment: 0)
      @user.user_spots.create(spot_id: 5, judgment: 0)

      get :index
      expect(response).to render_template("spots/index")
    end

    it "スポット情報が全て「行きたくない」でも、indexが表示されること" do
      @user.user_spots.create(spot_id: 1, judgment: 0)
      @user.user_spots.create(spot_id: 2, judgment: 0)
      @user.user_spots.create(spot_id: 3, judgment: 0)
      @user.user_spots.create(spot_id: 4, judgment: 0)
      @user.user_spots.create(spot_id: 5, judgment: 0)

      get :index
      expect(response).to render_template("spots/index")
    end

    it "User.spotsが4件の場合、newにリダイレクトすること" do
      @user.user_spots.create(spot_id: 1, judgment: 1)
      @user.user_spots.create(spot_id: 2, judgment: 1)
      @user.user_spots.create(spot_id: 3, judgment: 1)
      @user.user_spots.create(spot_id: 4, judgment: 1)

      get :index
      expect(response).to redirect_to(:action => 'new')
    end

    it "@rated_spotsにはuserに紐づくスポット情報がロードされていること" do
      @user.user_spots.create(spot_id: 1, judgment: 1)
      @user.user_spots.create(spot_id: 2, judgment: 1)
      @user.user_spots.create(spot_id: 3, judgment: 0)
      @user.user_spots.create(spot_id: 4, judgment: 0)
      @user.user_spots.create(spot_id: 5, judgment: 0)

      get :index
      expect(assigns(:rated_spots)).to eq @user.spots
    end

  end

  describe "GET new" do
    it "ログインしていなければ、トップページにリダイレクトされること" do
      logout_user
      get :new

      expect(response).to redirect_to root_path
    end

    it "サクセスすること" do
      get :new
      expect(response).to be_success
    end

    it "spots/newを描画すること" do
      get :new
      expect(response).to render_template("spots/new")
    end

  end
end
