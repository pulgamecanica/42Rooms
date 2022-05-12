class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :omniauthable, omniauth_providers: [:marvin]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  belongs_to :campus, optional: true
  has_many :white_lists
  devise :authenticatable
  enum role: {user42: 0, staff42: 1, admin: 2, other_user: 3}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  def is_admin?
    return role == 2
  end

  def is_staff?
    return role == 1
  end

  def to_s
    "#{self.login} [#{self.role}]".truncate(40)
  end
end
