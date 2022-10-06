class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :attendees, through: :attended_events, source: :attended_event
end
