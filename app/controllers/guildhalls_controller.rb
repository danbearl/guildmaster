class GuildhallsController < ApplicationController
  expose(:guildhalls)
  expose(:guildhall) { Guildhall.where("user_id = ?", params[:user_id]).first }
  def edit
  end

end
