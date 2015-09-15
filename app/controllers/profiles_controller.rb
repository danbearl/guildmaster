class ProfilesController < ApplicationController
  before_filter :user_owns_profile, only: [:edit, :update]

  expose(:profiles)
  expose(:profile) do
    Profile.where("user_id = ?", params[:user_id]).first ||
    Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])

    if @profile.update_attributes(profile_params)
      redirect_to user_profile_path(@profile.user.id), notice: "Profile successfully updated."
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:display_name, :about)
  end

  def user_owns_profile
    unless profile.user.id == current_user.id
      redirect_to user_profile_path(profile.user.id), notice: "You can only edit your own profile!"
      return false
    end
  end
end
