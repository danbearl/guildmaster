class GuildhallsController < ApplicationController
  before_filter :require_user, only:  [:edit, :update]
  before_filter :current_user_owns_guildhall, only: [:edit, :update]

  expose(:guildhalls)
  expose(:guildhall) do
    Guildhall.where("user_id = ?", params[:user_id]).first ||
    Guildhall.find(params[:id])
  end

  def update
    @guildhall = Guildhall.find(params[:id])

    if @guildhall.update_attributes(guildhall_params)
      redirect_to user_guildhall_path(@guildhall.user.id), notice: "Guild successfully updated."
    else
      render 'edit'
    end
  end

  private

  def current_user_owns_guildhall
    unless current_user.id == guildhall.user.id
      redirect_to :root
    end
    return false
  end

  def guildhall_params
    params.require(:guildhall).permit(:name)
  end
end
