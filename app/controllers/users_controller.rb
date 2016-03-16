class UsersController < ApplicationController
  def show
  	# Defining @user variable in the corresponding show action
  	# Technically, params[:id] is the string "1" but find is smart enough to covert it to an integer.
  	@user = User.find(params[:id])

  end

  def new
  end
end
