class Guildhall < ActiveRecord::Base
  belongs_to :user
  has_many :adventurers
  has_many :contracts

  after_initialize :init_guildhall

  private

  def init_guildhall
    self.gold = 10
    self.capacity = 4
  end
end
