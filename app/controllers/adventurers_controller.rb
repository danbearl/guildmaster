class AdventurersController < ApplicationController
  before_filter :require_user

  expose(:adventurers)
  expose(:adventurer)
  expose(:new_adventurers) { [Adventurer.create, Adventurer.create, Adventurer.create] }

  def new
    session[:adventurer_ids] = new_adventurers.map { |a| a.id }
  end

  def create
    unless adventurer.temp == true and session[:adventurer_ids].include?(adventurer.id)
      dump_temp_adventurers
      redirect_to :root, notice: "You can only hired one of the provided adventurers!"
      return
    end

    adventurer.update_attribute(:guildhall_id, current_user.guildhall.id)

    session[:adventurer_ids].delete_if {|id| id == adventurer.id}
    dump_temp_adventurers

    if adventurer.save
      redirect_to user_guildhall_path(current_user.id), notice: "#{adventurer.name} hired!"
      return
    else
      redirect_to :root, notice: "Something went wrong!"
      return
    end

  end

  private
  def dump_temp_adventurers
    session[:adventurer_ids].each do |id|
      Adventurer.find(id).destroy
    end
    session[:adventurer_ids] = []
  end

  def deny_user_access
    redirect_to :root, notice: "You must be logged in to do that."
  end

end
