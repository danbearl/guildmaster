class Guildhall < ActiveRecord::Base
  belongs_to :user
  has_many :adventurers
end
