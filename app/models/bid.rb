class Bid < ActiveRecord::Base
  belongs_to :quest
  belongs_to :guildhall
end
