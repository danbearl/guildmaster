require 'rails_helper'

describe Adventurer do
  it "initializes with a name and skills" do
    adventurer = Adventurer.new

    expect(adventurer.name).to_not be(nil)
    expect(adventurer.skills.empty?).to be(false)
  end
  it "should report its level" do
    adventurer = Adventurer.new

    expect(adventurer.level).to be(3)
  end

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


  it "should calculate its own advance" do
    adventurer = Adventurer.new

    #salary * 4
    expect(adventurer.advance).to be(4)
  end
end
