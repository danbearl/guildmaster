class GuildhallsController < ApplicationController
  expose(:guildhalls)
  expose(:guildhall) { Guildhall.where("user_id = ?", params[:user_id]).first }
  def update
    @guildhall = Guildhall.find(params[:id])

    if @guildhall.update_attributes(guildhall_params)
      redirect_to user_guildhall_path(@guildhall.user.id), notice: "Guild successfully updated."
    else
      render 'edit'
    end  
  end

  private
  def guildhall_params
    params.require(:guildhall).permit(:name)
  end
end
