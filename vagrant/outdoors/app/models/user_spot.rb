class UserSpot < ActiveRecord::Base
  belongs_to :user
  belongs_to :spot
end
