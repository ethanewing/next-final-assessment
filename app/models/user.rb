require 'bcrypt'

class User < ApplicationRecord
  include BCrypt
  enum role: [:admin, :regular]
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :encrypted_password, presence: true
  before_save :encrypt_password

  def self.authenticate(name, password)
    user = find_by_user_name(name)
    if user && user.encrypted_password == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if encrypted_password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(encrypted_password, salt)
    end
  end

end
