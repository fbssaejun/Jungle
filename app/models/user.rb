class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true
  validates :password, length: {minimum : 5}
end
