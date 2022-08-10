class Room < ApplicationRecord
  has_many :reservations, dependent: :delete_all
  has_many :white_lists, dependent: :delete_all
  enum status: {active: 0, inactive: 1, hidden: 2}
  enum room_type: {staff_room: 0,  normal_room: 1, club_room: 2}
  validates :name, length: { in: 5..20 }
  validates :description, length: { in: 5..100 }
  validates :capacity, numericality: { greater_than: 1 }
  validates_presence_of :description, :name, :capacity, :room_type, :status
  after_create :set_white_list

  #Friendly id for the routes
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  def set_white_list
    User.where(role: :staff42).each do |u|
      begin
        wl = self.white_lists.build(user: u)
        wl.save!
      rescue StandardError => e
        e.message
      end
    end
    if (self.room_type == "normal_room")
      User.where(role: :user42).each do |u|
        begin
          wl = self.white_lists.build(user: u)
          wl.save!
        rescue StandardError => e
          e.message
        end
      end
    end
  end

end