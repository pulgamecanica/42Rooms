module Admins
	class UsersController < AdminsController
		before_action :set_user, only: %i[ edit update destroy ]

    def index
      @users = User.all
    end

		def new
      @user = User.new
    end

		def edit
      @white_list = @user.white_lists.build
    end

		def create
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to edit_user_path(@user), notice: "User was successfully created." }
          format.json { render :edit, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

		def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to edit_user_path(@user), notice: "User was successfully updated." }
          format.json { render :edit, status: :ok, location: @user }
        else
          format.html { redirect_to edit_user_path(@user), status: :unprocessable_entity, notice: "ERROR User was not updated"}
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

  	def destroy
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    end

		private

		def set_user
      @user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:login, :email, :role, :campus_id)
    end
	end
end

