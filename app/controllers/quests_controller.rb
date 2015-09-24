class QuestsController < ApplicationController
  before_filter :require_user, except: [:award_quest_contracts]
  expose(:quests)
  expose(:quest)
  expose(:unclaimed_quests) { quests.select { quest.contract == nil } }

end
