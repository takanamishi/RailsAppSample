require 'rails_helper'

RSpec.describe Spot, :type => :model do
  before do
    @spots = Spot.all
  end

  it "スポット情報として5件登録されていること" do
    @spots.size.should == 5
  end

end
