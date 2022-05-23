module Admins
  class WhiteListsController < AdminsController

    def create
      @list = WhiteList.new(white_list_params)

      respond_to do |format|
        if @list.save
          format.html { redirect_to edit_room_path(@list.room), notice: "User was successfully added to the white list." }
          format.json { render :edit, status: :created, location: @list.room }
        else
          format.html { redirect_to edit_room_path(@list.room), status: :unprocessable_entity, notice: @list.errors.full_messages.first }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      list = WhiteList.find(params[:id])
      list.destroy
      respond_to do |format|
        format.html { redirect_to rooms_url, notice: "User was removed from the Wite List." }
        format.json { head :no_content }
      end
    end

    private

    def white_list_params
      params.require(:white_list).permit(:user_id, :room_id)
    end
  end
end

