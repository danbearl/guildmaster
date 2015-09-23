class TasksController < ApplicationController
  before_filter :require_user
  before_filter :user_owns_contract

  expose(:contract)
  expose(:adventurer)
  expose(:guildhall) { contract.guildhall }

  def create
    task = Task.new(contract_id: contract.id, adventurer_id: adventurer.id)

    task.result = adventurer.go_on_quest(contract.quest)
    task.ends_at = Date.today + task.result[:steps_completed]

    if task.save
      notice = "#{adventurer.name} has embarked on a new quest."
    else
      notice = "Something went wrong."
    end

    redirect_to adventurer.guildhall, notice: notice
  end

  private

  def user_owns_contract
    unless current_user.guildhall.id == contract.guildhall_id
      redirect_to :root
    end
    return false
  end
end
