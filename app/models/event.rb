class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :rsvps, foreign_key: "attended_event_id"
  has_many :attendees, through: :rsvps

  scope :past_event, -> { where('date < ?', Date.today) }
  scope :upcoming_event, -> { where('date >= ?', Date.today )}

  validates :name, :location, :date, presence: true
  validates :name, length: { maximum: 30 }
  validates :location, length: { in: 3..50 }

  # def self.past
  #   self.where("date < ?", Date.today)
  # end

  # def self.upcoming
  #   self.where("date >= ?", Date.today)
  # end
end
