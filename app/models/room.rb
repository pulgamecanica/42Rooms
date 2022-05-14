class Room < ApplicationRecord
  belongs_to :campus
  has_many :reservations
  has_many :black_lists
  enum status: {active: 0, inactive: 1, hidden: 2}
  enum room_type: {normal_room: 0, staff_room: 1, club_room: 2}
  validates_presence_of :description, :name, :capacity
  #Friendly id for the routes
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
