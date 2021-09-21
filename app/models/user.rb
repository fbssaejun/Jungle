class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 5}
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    lowercasedEmail = email.strip.downcase
    user = self.where("LOWER(email) LIKE ?", lowercasedEmail).first
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
