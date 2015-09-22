class QuestsController < ApplicationController
  expose(:quests)
  expose(:quest)
  expose(:unclaimed_quests) { quests.select { quest.contract == nil } }

  def index
  end

  def show
  end
end
