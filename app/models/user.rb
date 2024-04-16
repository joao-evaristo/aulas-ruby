require 'securerandom'
class User < ApplicationRecord
    before_create :generate_auth_token
    has_secure_password
    validates :name, presence: true, length: { maximum: 50 }
    validates :password, presence: true, length: { minimum: 8 }
    validate :password_complexity
    VALID_EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    validates :email, presence: true, length: { maximum: 260 }, format: { with: VALID_EMAIL_FORMAT }, uniqueness: { case_sensitive: false }
    before_save { self.email = email.downcase }

    def password_complexity
        if password.present? && !password.match(/^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/)
            errors.add(:password, "must contain at least one letter, one digit, and be at least 8 characters long")
        end
    end

    def generate_auth_token
        self.auth_token = SecureRandom.urlsafe_base64
    end
  end