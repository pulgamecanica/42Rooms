class Room < ApplicationRecord
  belongs_to :campus
  has_many :reservations
  has_many :white_lists
  enum status: {active: 0, inactive: 1, hidden: 2}
  enum room_type: {staff_room: 0,  normal_room: 1, club_room: 2}
  validates_presence_of :description, :name, :capacity
  #Friendly id for the routes
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  scope :visible, ->(campus = 0..Campus.all.count) { where(campus: campus).where(status: 0..1) }
  scope :available, ->(campus = 0..Campus.all.count) { where(campus: campus).where(status: 0) }
  scope :restricted, ->(campus = 0..Campus.all.count) { where(campus: campus).where(room_type: 0) }
  scope :unrestricted, -> (campus = 0..Campus.all.count) { where(campus: campus).where(room_type: 1..2) }
end