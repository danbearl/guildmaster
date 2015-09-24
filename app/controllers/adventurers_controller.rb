class AdventurersController < ApplicationController
  before_filter :require_user
  before_filter :user_owns_adventurer, only: [:fire]

  expose(:adventurers)
  expose(:adventurer)
  expose(:new_adventurers) { [Adventurer.create, Adventurer.create, Adventurer.create] }
  expose(:unemployed_adventurers) { Adventurer.where("guildhall_id = ?", 0) }
  expose(:guildhall) { current_user.guildhall }
  expose(:quest)

  def new
    session[:adventurer_ids] = new_adventurers.map { |a| a.id }
  end

  def fire
    adventurer.update_attribute(:guildhall_id, 0)
    adventurer.save
    redirect_to user_guildhall_path(current_user.id), notice: "#{adventurer.name} has left your guild."
  end

  def quest
    quest_log = adventurer.go_on_quest(quest)
    adventurer.quest_logs.create(body: quest_log[:body], success: quest_log[:success])
  end

  def hire
    validation = validate_for_hire

    unless validation[:valid?]
      redirect_to :root, notice: validation[:reason] and return
    else
      guildhall.update_attribute(:gold, guildhall.gold - adventurer.advance)
      adventurer.update_attribute(:guildhall_id, guildhall.id)
      redirect_to adventurer_market_path, notice: "#{adventurer.name} is now a member of your guild."
    end

  end

  def create
    validation = validate_for_hire

    unless adventurer.temp == true and session[:adventurer_ids].include?(adventurer.id) and validation[:valid?]
      dump_temp_adventurers
      redirect_to :root, notice: validation[:reason] and return
    end

    adventurer.update_attribute(:guildhall_id, current_user.guildhall.id)

    dump_temp_adventurers

    if adventurer.save
      redirect_to user_guildhall_path(current_user.id), notice: "#{adventurer.name} hired!"
    else
      render :new, notice: "Something went wrong!"
    end

  end

  private
  def validate_for_hire
    validation = {}
    if adventurer.guildhall_id != 0
      validation[:reason] = "That adventurer is already employed."
    elsif guildhall.adventurers.count >= guildhall.capacity
      validation[:reason] = "You cannot hire any more adventurers. Your guild is at capacity."
    elsif guildhall.gold < adventurer.advance
      validation[:reason] = "You can't afford to hire this adventurer."
    end

    validation[:valid?] = validation[:reason].nil? ? true : false
    validation
  end

  def dump_temp_adventurers
    session[:adventurer_ids].delete_if {|id| id == adventurer.id}
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
