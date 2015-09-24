require 'rails_helper'

describe TaskManager do
  describe '.generate_quests' do
    it "generates up to three new quests per user" do
      user = User.create(
        email: 'dan@example.com',
        password: 'pass',
        password_confirmation: 'pass'
      )

      TaskManager.generate_quests
      expect(Quest.all.count).to eq(3)
    end

    it "will not exceed three quests per user" do

      user = User.create(
        email: 'angela@gmail.com',
        password: 'pass',
        password_confirmation: 'pass'
      )

      Quest.create

      TaskManager.generate_quests

      expect(Quest.all.count).to eq(3)

    end
  end

  describe '.award_quest_contracts' do
    it 'awards contracts to the lowest bidder' do
      dan = User.create(
        email: 'dan@example.com',
        password: 'pass',
        password_confirmation: 'pass'
      )
      dan.create_guildhall

      angie = User.create(
        email: 'angie@example.com',
        password: 'pass',
        password_confirmation: 'pass'
      )
      angie.create_guildhall

      quest_1 = Quest.new
      quest_1.created_at = Time.now.to_date - 4
      quest_1.save

      Bid.create(
        guildhall_id: dan.guildhall.id,
        quest_id: quest_1.id,
        amount: 1
      )

      Bid.create(
        guildhall_id: angie.guildhall.id,
        quest_id: quest_1.id,
        amount: 10
      )

      TaskManager.award_quest_contracts

      expect(Contract.first.guildhall.user.id).to eq(dan.id)
    end
  end

  describe '.cancel_expired_contracts' do
    it "destroys expired contracts" do

    end
  end

end
