class UsersController < ApplicationController
  expose(:users)
  expose(:user)

  def create
    @user = User.new(user_params)
    @user.build_profile

    if @user.save
      redirect_to root_path, notice: "Welcome! Please take the time to fill out your profile!"
    else
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
