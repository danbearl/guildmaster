class Task < ActiveRecord::Base
  belongs_to :adventurer
  belongs_to :contract
  serialize :result
end
