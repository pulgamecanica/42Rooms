class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  enum subject: {club: "Club Related", staff42: "Staff Related", guest: "Guests Related", internship: "Internship Related", meeting: "Meeting Related"}

#  scope :awaiting, ->(campus = 0..Campus.all.count) { where(campus: campus).where(finished: false) }

end
