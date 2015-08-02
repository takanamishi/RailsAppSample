require 'rails_helper'

RSpec.describe Spot, :type => :model do

  before do
    @spot = Spot.new(name: "スポット名", body: "スポットの詳細", image_path: "rspec.png")
  end

  subject { @spot }

  it { should respond_to(:name) }
  it { should respond_to(:body) }
  it { should respond_to(:image_path) }

  it { should be_valid }

  describe "スポット情報は5件で固定" do
    fixtures :users, :spots

    before do
      @spots = Spot.all
      @user = users(:testuser)
      @spot = spots(:nanohana)
    end

    it "スポット情報として5件登録されていること" do
      expect(@spots.size).to eq 5
    end

    it "spot.user_spotsでUserSpotsに1件登録できること" do
        expect{
          @spot.user_spots.create(user_id: @user.id, judgment: 1)
        }.to change(UserSpot, :count).by(1)
    end

    it "UserSpotsに「行きたい（judgmentが1）」が1件ある場合、@user.spotsは1件になること" do
      @user.user_spots.create(spot_id: @spot.id, judgment: 1)
      expect(@user.spots.size).to eq 1
    end

    it "UserSpotsに「行きたい（judgmentが0）」が1件ある場合、@user.spotsは0件になること" do
      @user.user_spots.create(spot_id: @spot.id, judgment: 0)
      expect(@user.spots.size).to eq 0
    end
  end

end
