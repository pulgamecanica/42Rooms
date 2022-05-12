class Room < ApplicationRecord
  belongs_to :campus
  has_many :reservations
  has_many :white_lists
  enum status: {active: 0, inactive: 1, hidden: 2}
  validates_presence_of :description, :name, :capacity
end
