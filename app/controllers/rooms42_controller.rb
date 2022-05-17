class Rooms42Controller < ApplicationController

  def home
    
  end

  def show
    begin
      @room = Room.friendly.find(params[:id])
      @new_reservation = @room.reservations.build(user: current_user)
    rescue
      render :file => 'public/404.html', :status => :not_found, :layout => false
    end
  end

  def rooms
    @rooms = Room.all.where(status: 0..1)
    @rooms = @rooms.where(campus: current_user.campus).or(@rooms) if current_user
  end
end