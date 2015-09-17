require 'rails_helper'

describe Quest do
  it "initializes with random attributes" do
    quest = Quest.new
    expect(quest.title).to_not be(nil)
    expect(quest.steps).to_not be(nil)
    expect(quest.guildhall_id).to be(0)
    expect(quest.rewards).to_not be(nil)
    expect(quest.deadline).to_not be(nil)
    expect(quest.complete).to be(false)
  end
end
