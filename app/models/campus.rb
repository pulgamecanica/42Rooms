class Campus < ApplicationRecord
  has_many :users

  def to_s
    "#{self.name}, #{self.country} - #{self.address} - [#{self.language}]".truncate(40)
  end
end
