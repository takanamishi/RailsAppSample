class SpotsController < ApplicationController
  before_filter :require_login

  def index
    @spots = Spot.all
  end
end
