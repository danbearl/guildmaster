class QuestsController < ApplicationController
  before_filter :require_user, except: [:award_quest_contracts]
  expose(:quests)
  expose(:quest)
  expose(:unclaimed_quests) { quests.select { quest.contract == nil } }
  expose(:processing_quests) { quests.select { quest.created_at.to_date + 3 < Date.today } }

  def award_quest_contracts
    processing_quests.each do |quest|
      unless quest.bids.empty?
        lowest_bid = self.bids.sort { |a, b| a.amount <=> b.amount }.first
        contract = Contract.new(guildhall_id: bid.guildhall.id, quest_id: quest.id, amount: lowest_bid.amount)
        contract.save
      else
        quest.destroy
      end
    end
  end

end
