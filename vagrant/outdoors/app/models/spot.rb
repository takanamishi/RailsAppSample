class Spot < ActiveRecord::Base
  has_many :user_spot
  has_many :users, through: :user_spots
end
