class Rooms42Controller < ApplicationController

  def home
    
  end

  def show
    @room = Room.friendly.find(params[:id])
    #RENDER ERROR IF PAGE NOT FOUNDED
  end

  def rooms
    @rooms = Room.all.where(status: 0..1)
    @rooms = @rooms.where(campus: current_user.campus).or(@rooms) if current_user
  end
end
