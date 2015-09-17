require 'rails_helper'

describe Guildhall do
  it "initializes with a name and skills" do
    guildhall = Guildhall.new

    expect(guildhall.gold).to_not be(nil)
    expect(guildhall.capacity).to_not be(nil)
  end
end
