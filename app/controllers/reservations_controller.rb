class ReservationsController < ApplicationController
  

  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to room_path(@reservation.room), notice: "Reservation was successfully created." }
        format.json { render :edit, status: :created, location: @reservation }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity, notice: @reservation.errors.full_messages.first }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to edit_reservation_path(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :edit, status: :ok, location: @reservation }
      else
        format.html { redirect_to edit_reservation_path(@reservation), status: :unprocessable_entity,  notice: @reservation.errors.full_messages.first }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  private

	  def reservation_params
			params.require(:reservation).permit(:room_id, :user_id, :starts_at, :ends_at, :subject, :finished)
		end
end
