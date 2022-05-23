module Admins
	class UsersController < AdminsController
		before_action :set_user, only: %i[ edit update destroy ]

    def index
      @limit = params[:limit].nil? ? 5 : params[:limit].to_i
      @total = User.all.count
      if @limit >= @total
        @limit = @total
      end
      @page = params[:page].nil? ? 1 : params[:page].to_i
      if (@page - 1) * @limit >= User.all.count || @limit == 0
        return render :file => 'public/404.html', :status => :not_found, :layout => false
      end
      @users = User.all.offset((@page - 1) * @limit).limit(@limit).order(:id)
      @first = (@page - 1) * @limit
      @last = @first + @users.count
    end

		def new
      @user = User.new
    end

		def edit
      @white_list = @user.white_lists.build
      if (params[:all].nil?)
        @reservations = @user.reservations.active
      else
        @reservations = @user.reservations
      end
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

