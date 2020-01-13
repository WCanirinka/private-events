# frozen_string_literal: true

class User < ApplicationRecord
    has_many :events
    before_create :create_remember_token
    before_save { self.email = email.downcase }
    has_secure_password
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_token, User.encrypt(remember_token))
    end
    def forget
      update_attribute(:remember_token, nil)
    end
    def self.new_token
      SecureRandom.urlsafe_base64
    end
    def self.encrypt(string)
      Digest::SHA1.hexdigest(string)
    end
    private
    def create_remember_token
      self.remember_token = User.encrypt(User.new_token)
    end
  end