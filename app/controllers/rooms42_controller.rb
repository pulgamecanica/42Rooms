class Rooms42Controller < ApplicationController
  before_action :set_reservation, only: %i[ reservation edit_reservation ]


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

  def profile
  end

  def reservation
  end

  def find_reservation
    @rooms = Room.all
    @match_reservations = Array.new
    s_at = (params['date_day'].to_datetime)
    s_at += params['date_time(4i)'].to_i.hours
    s_at += params['date_time(5i)'].to_i.minutes
    now = DateTime.new(Time.zone.now.year, Time.zone.now.month, Time.zone.now.day, Time.zone.now.hour, Time.zone.now.min)
    duration = params['duration']
    e_at = s_at + duration.to_i.minutes
    if (!s_at.nil? && !e_at.nil? && s_at > now + 15.minutes)
      @match_rooms = Room.all
      @match_rooms = @match_rooms.reject do |room|
        reject_room = false
        room.reservations.where(finished: false).each do |res|
          if (s_at && s_at <= res.starts_at) # When the reservation start is before
            if (e_at && e_at >= res.starts_at) # When the reservation finishes after:
              reject_room = true
              break
            else
              next
            end
          elsif (e_at && e_at <= res.ends_at) # When the reservation start is between
            reject_room = true
            break
          end
        end
        reject_room
      end
      @match_rooms.each do |room|
        @match_reservations.push(room.reservations.build(starts_at: s_at, ends_at: e_at, user: current_user))
      end
    end
    render :rooms, status: :ok
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