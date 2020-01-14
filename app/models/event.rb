class Event < ApplicationRecord
  scope :upcoming, -> { where('date > ?', Date.today) }
  scope :past, -> { where('date < ?', Date.today) }
  
  belongs_to :user
  has_many :attendances
  has_many :attendees, through: :attendances
end
