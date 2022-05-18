module Admins
	class RoomsController < AdminsController
		before_action :set_room
		before_action :set_room, only: %i[ edit update destroy ]

		def new
      @room = Room.new
    end

		def edit
      @white_list = @room.white_lists.build
    end

		def create
      @room = Room.new(room_params)

      respond_to do |format|
        if @room.save
          format.html { redirect_to edit_room_path(@room), notice: "Room was successfully created." }
          format.json { render :edit, status: :created, location: @room }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      end
    end

		def update
      respond_to do |format|
        if @room.update(room_params)
          format.html { redirect_to edit_room_path(@room), notice: "Room was successfully updated." }
          format.json { render :edit, status: :ok, location: @room }
        else
          format.html { redirect_to edit_room_path(@room), status: :unprocessable_entity, notice: "ERROR Room was not updated"}
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      end
    end

  	def destroy
      @room.destroy

      respond_to do |format|
        format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
        format.json { head :no_content }
      end
    end

		private

		def set_room
      @room = Room.friendly.find(params[:id])
		end

		def room_params
			params.require(:room).permit(:name, :description, :campus_id, :room_type, :status, :capacity)
    end
	end
end

