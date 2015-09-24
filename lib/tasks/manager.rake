namespace :manager do
  desc "Pay All Adventurers"
  task pay_adventurers: :environment do
    TaskManager.pay_adventurers
  end

  desc "Destroy unfulfilled, expired contracts"
  task cancel_expired_contracts: :environment do
    TaskManager.cancel_expired_contracts
  end

  desc "Award contracts to lowest bidders"
  task award_quest_contracts: :environment do
    TaskManager.award_quest_contracts
  end

  desc "Generate new quests"
  task generate_quests: :environment do
    TaskManager.generate_quests
  end

  desc "Complete quests"
  task complete_quests: :environment do
    TaskManager.complete_quests
  end
end
