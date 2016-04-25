class UsersController < ApplicationController
  # Only edit or update if user is logged in
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
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

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
