class BlackList < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # Make sure that there is only one instance for any pair of "[user <-> room]"
  validates_uniqueness_of :user_id, :scope => [:room_id]
end
