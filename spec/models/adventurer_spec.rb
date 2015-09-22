require 'rails_helper'

describe Adventurer do
  #adventurer#init_adventurer
  it "initializes with a name and skills" do
    adventurer = Adventurer.new

    expect(adventurer.name).to_not be(nil)
    expect(adventurer.skills.empty?).to be(false)
  end

  #adventurer#level
  it "should report its level" do
    adventurer = Adventurer.new

    expect(adventurer.level).to be(3)
  end

  #adventurer#salary
  it "should calculate its own salary" do
    adventurer = Adventurer.new

    #(level / 4).floor + 1
    expect(adventurer.salary).to be(1)

    adventurer.skills = {
      archery: 3,
      melee: 5,
      stealth: 3,
    }

    expect(adventurer.salary).to be(3)

  end


  #adventurer#advance
  it "should calculate its own advance" do
    adventurer = Adventurer.new

    #salary * 4
    expect(adventurer.advance).to be(4)
  end

  #adventurer#go_on_quest
  it "can go on a quest" do
    adventurer = Adventurer.new
    quest = Quest.new
    quest_result = adventurer.go_on_quest(quest)

    expect(quest_result[:success]).to_not be(nil)
    expect(quest_result[:body]).to_not be(nil)
  end
end
