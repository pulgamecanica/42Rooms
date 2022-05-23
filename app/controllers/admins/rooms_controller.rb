module Admins
	class RoomsController < AdminsController
		before_action :set_room, only: %i[ edit update destroy ]

    def index
      @limit = params[:limit].nil? ? 5 : params[:limit].to_i
      @total = Room.all.count
      if @limit >= @total
        @limit = @total
      end
      @page = params[:page].nil? ? 1 : params[:page].to_i
      if (@page - 1) * @limit >= Room.all.count || @limit == 0
        return render :file => 'public/404.html', :status => :not_found, :layout => false
      end
      @rooms = Room.all.offset((@page - 1) * @limit).limit(@limit).order(:id)
      @first = (@page - 1) * @limit
      @last = @first + @rooms.count
      @pages = 0
    end

		def new
      @room = Room.new
    end

		def edit
      @white_list = @room.white_lists.build
      if (params[:all].nil?)
        @reservations = @room.reservations.active
      else
        @reservations = @room.reservations
      end
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
          format.html { redirect_to edit_room_path(@room), status: :unprocessable_entity, notice: @room.errors.full_messages}
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end
      end
    end

  	def destroy
      @room.destroy

      respond_to do |format|
        format.html { redirect_to rooms_path, notice: "Room was successfully destroyed." }
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

