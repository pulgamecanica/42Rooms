class WhiteList < ApplicationRecord
  belongs_to :room
  belongs_to :user

  # Make sure that there is only one instance for any pair of "[user <-> room]"
  validates_uniqueness_of :user_id, :scope => [:room_id]
end
