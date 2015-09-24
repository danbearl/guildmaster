class Contract < ActiveRecord::Base
  belongs_to :quest
  belongs_to :guildhall
  has_one :task, dependent: :destroy
end
