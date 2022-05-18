class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  enum subject: {club: "Club Related", staff42: "Staff Related", guest: "Guests Related", internship: "Internship Related", meeting: "Meeting Related"}
  validates :ends_at, comparison: { greater_than: :starts_at }
  validate :reservation_starts_at_least_10min_from_now, :check_overlapping

  scope :active, -> { where(finished: false) }

  def reservation_starts_at_least_10min_from_now
    if starts_at < Time.now + 10.minutes
      errors.add(:starts_at, "Reservation start time must be at least 10 min from now!")
    end
  end

  def check_overlapping
    room.reservations.active.without(self).each do |res|
      if starts_at < res.starts_at && ends_at > res.starts_at
        errors.add(:ends_at, "Reservation overlaps another reservation, finished in the middle of another reservation")
      elsif starts_at > res.starts_at && starts_at < res.ends_at
        errors.add(:starts_at, "Reservation overlaps another reservation, starts in the middle of another reservation")
      end
    end
  end
  def to_s
    if self.errors
      return super()
    end
    return "#{starts_at.strftime("%d/%m/%y")} (#{starts_at.strftime("%H:%M")}-#{ends_at.strftime("%H:%M")}), #{subject}"
  end
  def is_club_reservation?
    subject == "club"
  end

  def is_staff_reservation?
    subject == "staff42"
  end

  def is_guest_reservation?
    subject == "guest"
  end
  
  def is_internship_reservation?
    subject == "internship"
  end
  
  def is_meeting_reservation?
    subject == "meeting"
  end

  def subject_number
    if is_club_reservation?
      return 1
    elsif is_staff_reservation?
      return 2
    elsif is_guest_reservation?
      return 3
    elsif is_internship_reservation?
      return 4
    elsif is_meeting_reservation?
      return 5
    end
  end
#  scope :awaiting, ->(campus = 0..Campus.all.count) { where(campus: campus).where(finished: false) }

end
