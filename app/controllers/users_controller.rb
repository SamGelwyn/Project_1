class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  # Fat Models, Thin Controllers

  def create
    @user = User.new user_params

    if @user.save # returns truthy on success
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Project_1!"
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
