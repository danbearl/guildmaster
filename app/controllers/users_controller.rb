class UsersController < ApplicationController
  expose(:users)
  expose(:user)

  def create
    @user = User.new(user_params)
    @user.build_profile
    @user.profile.display_name = params[:display_name]

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
