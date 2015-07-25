class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :user_spots, -> {where(judgment: 1)}
  has_many :spots, through: :user_spots

  validates :password, confirmation: true, length: { in: 6..24 }, if: :password
  validates :password_confirmation, presence: true, if: :password

  validates :email, presence: true, uniqueness: { case_sensitive:false }
end
