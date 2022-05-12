class Rooms42Controller < ApplicationController

  def home
    
  end

  def rooms
    @rooms = Room.all.where(status: 0..1)
  end
end
