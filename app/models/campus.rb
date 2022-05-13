class Campus < ApplicationRecord
  has_many :users
  has_many :rooms

  def to_s
    "#{self.name}, #{self.country} - #{self.address} - [#{self.language}]".truncate(40)
  end
end
