class Rooms42Controller < ApplicationController
  before_action :set_reservation, only: %i[ reservation edit_reservation ]

  def home
    
  end

  def edit_reservation
    @new_reservation = @reservation
    if current_user.nil?
      redirect_to root_path, notice: "User must be logged in" 
    end
  end

  def change_theme
    if !current_user.nil?
      theme = current_user.theme == "light" ? "dark" : "light"
      current_user.update(theme: theme)
      render json: @current_user
    else
      render status: :forbidden
    end
  end

  def reservation
  end

  def calendar
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

  private

    def set_reservation
      begin
        @reservation = Reservation.find(params[:id])
      rescue
        render :file => 'public/404.html', :status => :not_found, :layout => false
      end
    end
end