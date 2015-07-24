class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, confirmation: true, length: { in: 6..24 }, if: :password
  validates :password_confirmation, presence: true, if: :password

  validates :email, presence: true, uniqueness: { case_sensitive:false }
end
