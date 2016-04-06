class UsersController < ApplicationController
  def show
    # Defining @user variable in the corresponding show action
    # Technically, params[:id] is the string "1" but find is smart enough to covert it to an integer.
    @user = User.find(params[:id])

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) # Not the final implementation!
    if @user.save
      # Log user in automatically after registration
      log_in @user
      # Hangle a successful save.
      flash[:success] = "Welcome to the Mini CMS"
      redirect_to @user
      # or just redirect_top user_url(@user)
    else
      render 'new'
    end
  end

  private # This is only used internaly by the User Controller

    def user_params
      params.require(:user).permit(
        :name, 
        :email, 
        :password, 
        :password_confirmation)
    end
end
