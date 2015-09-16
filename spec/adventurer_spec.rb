require 'rails_helper'

describe Adventurer do
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
end
