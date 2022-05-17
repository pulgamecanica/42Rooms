class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  enum subject: {club: "Club Related", staff42: "Staff Related", guest: "Guests Related", internship: "Internship Related", meeting: "Meeting Related"}
  validates :ends_at, comparison: { greater_than: :starts_at }

  def to_s
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
