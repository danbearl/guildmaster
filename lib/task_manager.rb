class TaskManager

  def self.generate_quests
    available_quests = Quest.all.select { |quest| quest.contract == nil || !quest.complete}
    max = User.all.count * 3
    if max > available_quests.count
      (max - available_quests.count).times do
        Quest.create
      end
    end
  end

  def self.award_quest_contracts
    Quest.all.select { |quest| quest.created_at.to_date + 3 < Date.today }.each do |quest|
      unless quest.bids.empty?
        lowest_bid = quest.bids.sort { |a, b| a.amount <=> b.amount }.first
        contract = Contract.new(guildhall_id: lowest_bid.guildhall.id, quest_id: quest.id, amount: lowest_bid.amount)
        contract.save
      else
        quest.destroy
      end
    end
  end

  def self.complete_quests
    processing_tasks = Task.where("ends_on < ?", Date.today)

    processing_tasks.each do |task|
      if task.result[:success]
        initial_gold = task.adventurer.guildhall.gold
        task.adventurer.guildhall.update_attribute(gold: initial_gold + task.contract.amount)
        task.quest.update_attribute(complete: true)
        task.contract.destroy
      end

      task.adventurer.quest_logs.create(task.result[:body])
      task.destroy
      adventurer.save if adventurer.changed?
    end
  end

  def self.cancel_expired_contracts
    contracts = Contract.all.select { |contract| contract.quest.deadline < Date.today && contract.task.nil? }
    contracts.each do |contract|
      contract.destroy
    end
  end

  def self.pay_adventurers
    User.all.each do |user|
      gold = user.guildhall.gold
      user.guildhall.adventurers.each do |adventurer|
        if gold < adventurer.salary
          adventurer.update_attribute(:guildhall_id, 0)
        else
          gold -= adventurer.salary
        end

        adventurer.save if adventurer.changed?
      end

      user.guildhall.update_attribute(:gold, gold)
      user.guildhall.save if user.guildhall.changed?
    end


  end

end
