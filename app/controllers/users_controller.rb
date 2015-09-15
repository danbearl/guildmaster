class UsersController < ApplicationController
  before_filter :require_user, only: [:destroy]
  before_filter :current_user_is_user, only: [:destroy]
  expose(:users)
  expose(:user)

  def create
    @user = User.new(user_params)
    @user.build_profile
    @user.build_guildhall
    @user.profile.display_name = params[:display_name]
    @user.guildhall.name = "#{params[:display_name]}'s Guild"

    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "Account successfully created!"
    else
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
