# frozen_string_literal: true

class User < ApplicationRecord
    before_create :create_remember_token
    before_save { self.email = email.downcase }
    attr_accessor :remember_token
    attr_accessor :session_token
    has_many :events, dependent: :destroy
    has_many :attendances, foreign_key: 'attendee_id'
    has_many :attendings, through: :attendances, source: :event

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

    def attend(event)
      attendings << event
    end

    def unattend(event)
      attendings.delete(event)
    end

    def attending?(event)
      attendings.include?(event)
    end

    private

      def create_remember_token
        self.remember_token = User.encrypt(User.new_token)
      end
  end
