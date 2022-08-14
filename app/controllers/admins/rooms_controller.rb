require 'csv'

module Admins
	class RoomsController < AdminsController
		before_action :set_room, only: %i[ edit update destroy]

    def import_to_whitelist
      import_to_list("white_list")
    end

    def import_to_blacklist
      import_to_list("black_list")
    end

    def index
      @limit = params[:limit].nil? ? 5 : params[:limit].to_i
      @total = Room.all.count
      if @limit >= @total
        @limit = @total
      end
      @page = params[:page].nil? ? 1 : params[:page].to_i
      if (((@page - 1) * @limit >= Room.all.count || @limit == 0) && @total != 0)
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
      @black_list = @room.black_lists.build
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

    def import_to_list(option)
      import_file = params[:file]
      room = Room.friendly.find(params[:room_id])
      return redirect_to edit_room_path(room), status: :not_found, alert: "File not Founded" if import_file.nil?
      case import_file.original_filename.split(".").last.downcase
        when "csv"          
          begin
            file = CSV.open(import_file.path, "r")
            array = file.read
            file.close
            raise "not_closed" if not file.closed?
            headers = array.shift.map { |header| header.chomp.strip.downcase }
            raise "invalid_headers" if headers != ["email"]
          rescue StandardError => e 
            return redirect_to edit_room_path(room), status: 422, alert: "#{e.message}, #{import_file.original_filename} is not valid"
          end
          array.each do |row|
            begin
              u = User.find_by(email: row[0].chomp.strip)
              if option == "white_list"
                white_list = u.white_lists.build(room: room)
                white_list.save
              elsif option == "black_list"
                black_list = u.black_lists.build(room: room)
                black_list.save
              end
            rescue StandardError => e 
              next
            end
          end
        when "json"
          # TODO JSON
        when "xml"
          # TODO XML
        else
          return redirect_to edit_room_path(room), status: 422, alert: "#{import_file.original_filename} file extention not allowed"
      end
      return redirect_to edit_room_path(room), status: :found, notice: "successfully parsed #{import_file.original_filename}!"
    end

		def room_params
			params.require(:room).permit(:name, :description, :room_type, :status, :capacity)
    end
	end
end

