require 'rails_helper'

RSpec.describe Spot, :type => :model do
  fixtures :users, :spots

  before do
    @spots = Spot.all
    @user = users(:testuser)
    @spot = spots(:nanohana)
  end

  it "スポット情報として5件登録されていること" do
    @spots.size.should == 5
  end

  it "spot.user_spotsでUserSpotsに1件登録できること" do
    lambda {
      @spot.user_spots.create(
        user_id: @user.id,
        judgment: 1)
      }.should change(UserSpot, :count).by(1)
  end

  it "UserSpotsに「行きたい（judgmentが1）」が1件ある場合、@user.spotsは1件になること" do
    @user.user_spots.create(spot_id: @spot.id, judgment: 1)
    @user.spots.size.should == 1
  end

  it "UserSpotsに「行きたい（judgmentが0）」が1件ある場合、@user.spotsは0件になること" do
    @user.user_spots.create(spot_id: @spot.id, judgment: 0)
    @user.spots.size.should == 0
  end

end
