class AdventurersController < ApplicationController
  before_filter :require_user
  before_filter :user_owns_adventurer, only: [:fire]

  expose(:adventurers)
  expose(:adventurer)
  expose(:new_adventurers) { [Adventurer.create, Adventurer.create, Adventurer.create] }
  expose(:unemployed_adventurers) { Adventurer.where("guildhall_id = ?", 0) }
  expose(:guildhall) { current_user.guildhall }

  def new
    session[:adventurer_ids] = new_adventurers.map { |a| a.id }
  end

  def fire
    adventurer.update_attribute(:guildhall_id, 0)
    adventurer.save
    redirect_to user_guildhall_path(current_user.id), notice: "#{adventurer.name} has left your guild."
  end

  def hire
    if adventurer.guildhall_id != 0
      notice = "That adventurer is already employed."
    elsif guildhall.adventurers.count >= guildhall.capacity
      notice = "You cannot hire any more adventurers. Your guild is at capacity."
    else
      if guildhall.gold >= adventurer.advance
        guildhall.update_attribute(:gold, guildhall.gold - adventurer.advance)
        adventurer.update_attribute(:guildhall_id, guildhall.id)
        notice = "#{adventurer.name} is now a member of your guild."
      else
        notice = "You can't afford #{adventurer.name}'s advance."
      end
    end

    redirect_to adventurer_market_path, notice: notice
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

  def user_owns_adventurer
    unless current_user.guildhall.id == adventurer.guildhall_id
      redirect_to :root
    end
    return false
  end

end
