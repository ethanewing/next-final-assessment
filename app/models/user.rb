class User < ApplicationRecord
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
end
