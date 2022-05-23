class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :omniauthable, omniauth_providers: [:marvin]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  belongs_to :campus, optional: true
  has_many :white_lists, dependent: :delete_all
  has_many :reservations, dependent: :delete_all
  devise :authenticatable
  enum role: {user42: 0, staff42: 1, admin: 2, other_user: 3}
  enum theme: {light: 0, dark: 1}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  after_create :set_white_list

  def is_admin?
    return role == "admin"
  end

  def is_staff?
    return role == "staff42"
  end

  def is_user42?
    return role == "user42"
  end

  def set_white_list
    if is_staff?
      Room.where(campus: self.campus).each do |r|
        begin
          wl = self.white_lists.build(room: r)
          wl.save!
        rescue StandardError => e
          e.message
        end
      end
    elsif is_user42?
      Room.where(campus: self.campus).where(room_type: "normal_room").each do |r|
        begin
          wl = self.white_lists.build(room: r)
          wl.save!
        rescue StandardError => e
          e.message
        end
      end
    end
  end

  def to_s
    "#{self.login} [#{self.role}]".truncate(40)
  end
end
