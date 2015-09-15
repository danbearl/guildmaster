class User < ActiveRecord::Base
  include Authem::User
  has_one :profile, dependent: :destroy
  has_one :guildhall, dependent: :destroy
end
