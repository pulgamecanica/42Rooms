class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  enum subject: {club: "Club Related", staff42: "Staff Related", guest: "Guests Related", internship: "Internship Related", meeting: "Meeting Related"}
  validates :user, presence: true
  validates :room, presence: true
  validates :ends_at, comparison: { greater_than: :starts_at }

  # On Create and Update check that reservations doesn't overlap, check the user list status (black & white lists), check the duration
  validate :check_overlapping, :reservation_duration, :check_list
  # On Create check that the reservation is at least 10 minutes from the current time
  validate :reservation_starts_at_least_10min_from_now, on: :create

  scope :active, -> { where(finished: false) }

  def reservation_starts_at_least_10min_from_now
    if starts_at < Time.zone.now + 10.minutes
      errors.add(:starts_at, "Reservation start time must be at least 10 min from now!")
    end
  end

  def check_overlapping
    return errors.add(:room, "Room must exist") if room.nil?
    room.reservations.active.without(self).each do |res|
      if starts_at <= res.starts_at && ends_at >= res.starts_at
        errors.add(:ends_at, "Reservation overlaps another reservation, finished in the middle of another reservation")
      elsif starts_at >= res.starts_at && starts_at <= res.ends_at
        errors.add(:starts_at, "Reservation overlaps another reservation, starts in the middle of another reservation")
      end
    end
  end

  def reservation_duration
    if ends_at - starts_at < 15.minutes
      errors.add(:starts_at, "Reservation must be at least 15 minutes long")
      errors.add(:ends_at, "Reservation must be at least 15 minutes long")
    elsif ends_at - starts_at > 2.hours
      errors.add(:starts_at, "Reservation can't be more than 2 hours long")
      errors.add(:ends_at, "Reservation can't be more than 2 hours long")
    end
  end

  def check_list
    return errors.add(:room, "Room must exist") if room.nil?
    if user.nil?
      errors.add(:user, "User must exist")
    elsif user.role == "blocked"
      errors.add(:user, "User is blocked!")
    elsif not room.black_lists.where(user: user).empty?
      errors.add(:user, "User belongs to the black list")
    elsif room.white_lists.where(user: user).empty? && !user.is_admin?
      errors.add(:user, "User must belong to the white list in order to add a reservation")
    end
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
  
  def to_s
    if self.errors.any?
      return super()
    end
    return "#{starts_at.strftime("%d/%m/%y")} (#{starts_at.strftime("%H:%M")}-#{ends_at.strftime("%H:%M")}), #{subject}"
  end
end
